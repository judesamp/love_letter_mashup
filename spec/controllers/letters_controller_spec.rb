require 'spec_helper'

describe LettersController do 

  let(:letter_order) { FactoryGirl.create(:letter_order) }
  let(:user) { User.find(letter_order.user_id) }
  let(:letter) { Letter.find(letter_order.letter_id) }
  let(:letter2) { FactoryGirl.create(:letter) }
  let(:letter3) { FactoryGirl.create(:letter) }
  let(:author) { FactoryGirl.create(:author) }
  let(:snippet) { FactoryGirl.create(:snippet) }

  describe 'GET #index' do

    it "should assign current users collection of letters" do
      local_user = User.find(letter_order.user_id)
      local_letter = Letter.find(letter_order.letter_id)
      login(local_user)
      get :index
      expect(assigns(:letters)).to include local_letter
    end

  end

  describe 'GET #show' do

    it "should assign an offset for retrieving letters" do
      login(user)
      FactoryGirl.create(:letter)
      xhr :get, :show, id: letter, workspace: "full_letter_workspace", offset: 1, :format => "js"
      expect(assigns(:offset)).to eq 1
    end

    it "assigns a direction" do
      login(user)
      FactoryGirl.create(:letter)
      xhr :get, :show, id: letter, workspace: "full_letter_workspace", offset: 1, direction: "next", :format => "js"
      expect(assigns(:direction)).to eq "next"
    end

    it "assigns the current_letter" do
      login(user)
      letter2 = FactoryGirl.create(:letter)
      xhr :get, :show, id: letter, workspace: "full_letter_workspace", offset: 1, direction: "next", :format => "js"
      expect(assigns(:current_letter)).to eq letter2
    end

    it "assigns the next letter" do
      login(user)
      FactoryGirl.create(:letter)
      letter3 = FactoryGirl.create(:letter)
      xhr :get, :show, id: letter, workspace: "full_letter_workspace", offset: 1, direction: "next", :format => "js"
      expect(assigns(:next_letter)).to eq letter3
    end

    context "the previous letter" do

      it "assigns previous letter to nil if offset equals 0" do
        login(user)
        FactoryGirl.create(:letter)
        FactoryGirl.create(:letter)
        xhr :get, :show, id: letter, workspace: "full_letter_workspace", offset: 0, direction: "next", :format => "js"
        expect(assigns(:previous_letter)).to eq nil
      end

      it "assigns previous letter to offset of -1 if offset is greater than 0" do
        login(user)
        letter2 = FactoryGirl.create(:letter)
        FactoryGirl.create(:letter)
        xhr :get, :show, id: letter, workspace: "full_letter_workspace", offset: 2, direction: "next", :format => "js"
        expect(assigns(:previous_letter)).to eq letter2
      end

    end

  end

  describe "POST #create" do

    it "creates a new letter" do
      login(user)
      request.env["HTTP_REFERER"] = "where_i_came_from"
      expect{
        post :create, letter: FactoryGirl.attributes_for(:letter)
      }.to change(Letter, :count).by(1)
    end

     it "redirects to index" do
      login(user)
      request.env["HTTP_REFERER"] = "where_i_came_from"
      post :create, letter: FactoryGirl.attributes_for(:letter)
      response.should redirect_to "where_i_came_from"
    end

  end

  describe 'GET #switch_workspace' do
    
    it "assigns a workspace name to @workspace" do
      login(user)
      xhr :get, :switch_workspace, workspace: "workspace_name", :format => "js"
      expect(assigns(:workspace)).to eq 'workspace_name'
    end

    context "workspace equals full_letter_workspace" do
   
      it "assigns an offset of 0 to @offset" do
        login(user)
        xhr :get, :switch_workspace, workspace: "full_letter_workspace", :format => "js"
        expect(assigns(:offset)).to eq 0
      end

      it "assigns the first letter to @current_letter" do
        login(user)
        xhr :get, :switch_workspace, workspace: "full_letter_workspace", :format => "js"
        expect(assigns(:current_letter)).to eq letter
      end
      it "assigns @previous_letter to nil" do
        login(user)
        xhr :get, :switch_workspace, workspace: "full_letter_workspace", :format => "js"
        expect(assigns(:previous_letter)).to eq nil
      end

      it "assigns @next_letter to the second letter" do
        second_letter = letter2
        login(user)
        xhr :get, :switch_workspace, workspace: "full_letter_workspace", :format => "js"
        expect(assigns(:next_letter)).to eq second_letter
      end

    end

  end

  describe 'POST #create_with_snippet' do
    it "should find appropriate letter and assign it to @letter" do
      login(user)
      current_letter = user.letters.create!(FactoryGirl.attributes_for(:letter) )
      current_snippet = FactoryGirl.create(:snippet)
      xhr :post, :create_with_snippet, :letter => { :letter_id => current_letter.id, :snippet_id => current_snippet.id }
      expect(assigns(:letter)).to eq current_letter
    end

    it "should find the appropriate snippet and assign it to @snippet" do
      login(user)
      current_letter = user.letters.create!(FactoryGirl.attributes_for(:letter) )
      current_snippet = FactoryGirl.create(:snippet)
      xhr :post, :create_with_snippet, :letter => { :letter_id => current_letter.id, :snippet_id => current_snippet.id }
      expect(assigns(:snippet)).to eq current_snippet
    end

    it "should create a new letter snippet (for current letter)" do
      login(user)
      current_letter = user.letters.create!(FactoryGirl.attributes_for(:letter) )
      current_snippet = FactoryGirl.create(:snippet)
      expect{
        xhr :post, :create_with_snippet, :letter => { :letter_id => current_letter.id, :snippet_id => current_snippet.id }
      }.to change(LetterSnippet, :count).by(1)
    end

  end

  describe 'GET #add_or_subtract_snippet' do

    it "should assign current_snippet to @snippet" do
      login(user)
      current_letter = user.letters.create!(FactoryGirl.attributes_for(:letter) )
      current_snippet = FactoryGirl.create(:snippet)
      xhr :patch, :add_or_subtract_snippet, letter_id: current_letter, :snippet => { :snippet_id => current_snippet.id, :checked => "true" }
      expect(assigns(:snippet)).to eq current_snippet
    end

    context "checked is false" do

      it "should assign current_snippet to @snippet" do
        login(user)
        current_letter = user.letters.create!(FactoryGirl.attributes_for(:letter) )
        current_snippet = FactoryGirl.create(:snippet)
        xhr :patch, :add_or_subtract_snippet, letter_id: current_letter, :snippet => { :snippet_id => current_snippet.id, :checked => "false" }
        expect(assigns(:snippet)).to eq current_snippet
      end

      it "should create a new letter snippet" do
        login(user)
        current_letter = user.letters.create!(FactoryGirl.attributes_for(:letter) )
        current_snippet = FactoryGirl.create(:snippet)
        expect{
          xhr :patch, :add_or_subtract_snippet, letter_id: current_letter, :snippet => { :snippet_id => current_snippet.id, :checked => "false" }
        }.to change(LetterSnippet, :count).by(1)
      end

      it "should set new letter snippet poition correctly" do
        login(user)
        current_letter = user.letters.create!(FactoryGirl.attributes_for(:letter) )
        current_snippet = FactoryGirl.create(:snippet)
        xhr :patch, :add_or_subtract_snippet, letter_id: current_letter, :snippet => { :snippet_id => current_snippet.id, :checked => "false" }
        current_letter_snippet = LetterSnippet.where(:letter_id => current_letter.id).where(:snippet_id => current_snippet.id).first
        expect(current_letter_snippet.position).to eq 1
      end

    end

    context "checked is true" do

      it "should assign current_letter to @letter" do
        login(user)
        current_letter = user.letters.create!(FactoryGirl.attributes_for(:letter) )
        current_snippet = FactoryGirl.create(:snippet)
        xhr :patch, :add_or_subtract_snippet, letter_id: current_letter, :snippet => { :snippet_id => current_snippet.id, :checked => "true" }
        expect(assigns(:letter)).to eq current_letter
      end

      it "should delete specified snippet" do
        login(user)
        current_letter = user.letters.create!(FactoryGirl.attributes_for(:letter) )
        current_snippet = FactoryGirl.create(:snippet)
        current_letter.snippets << current_snippet
        expect{
          xhr :patch, :add_or_subtract_snippet, letter_id: current_letter, :snippet => { :snippet_id => current_snippet.id, :checked => "true" }
        }.to change(LetterSnippet, :count).by(-1)
      end

    end

  end

  describe 'GET #update_positions' do

    it "should update snippet position as specified" do
      login(user)
      current_letter = user.letters.create!(FactoryGirl.attributes_for(:letter) )
      snippet_1 = FactoryGirl.create(:snippet)
      snippet_2 = FactoryGirl.create(:snippet)
      current_letter.snippets << snippet_1
      current_letter.snippets << snippet_2
      xhr :patch, :update_positions, letter_id: current_letter,  Activity: "[{\"letter_id\":\"#{current_letter.id}\",\"snippet_id\":\"#{snippet_1.id}\",\"position\":1},{\"letter_id\":\"#{current_letter.id}\",\"snippet_id\":\"#{snippet_2.id}\",\"position\":2}]", "letter_id"=>"#{current_letter.id}}"
      letter_snippet = LetterSnippet.where(:letter_id => current_letter.id).where(:snippet_id => snippet_1.id).first
      expect(letter_snippet.position).to eq 1
    end

    it "should update snippet position as specified (passing in different positions)" do
      login(user)
      current_letter = user.letters.create!(FactoryGirl.attributes_for(:letter) )
      snippet_1 = FactoryGirl.create(:snippet)
      snippet_2 = FactoryGirl.create(:snippet)
      current_letter.snippets << snippet_1
      current_letter.snippets << snippet_2
      xhr :patch, :update_positions, letter_id: current_letter,  Activity: "[{\"letter_id\":\"#{current_letter.id}\",\"snippet_id\":\"#{snippet_2.id}\",\"position\":1},{\"letter_id\":\"#{current_letter.id}\",\"snippet_id\":\"#{snippet_1.id}\",\"position\":2}]", "letter_id"=>"#{current_letter.id}}"
      letter_snippet = LetterSnippet.where(:letter_id => current_letter.id).where(:snippet_id => snippet_1.id).first
      expect(letter_snippet.position).to eq 2
    end

  end

  describe 'GET #create_with_quiz' do

    it "should create a letter using output from the quiz" do
      LettersController.any_instance.stub(:set_snippet).and_return(Snippet.create(content: 'here is the content'))
      login(user)
      expect{
        xhr :get, :create_with_quiz, :question_1 =>"A", :question_2 => "B", :question_3 => "A", :question_4 => "B", :question_5 => "B", format: 'js'
      }.to change(Letter, :count).by(1)
    end

    it "should create a letter with five snippets using output from the quiz" do
      LettersController.any_instance.stub(:set_snippet).and_return(Snippet.create(content: 'here is the content'))
      login(user)
      xhr :get, :create_with_quiz, :question_1 =>"A", :question_2 => "B", :question_3 => "A", :question_4 => "B", :question_5 => "B", format: 'js'
      letter = Letter.last
      expect(letter.snippets.length).to eq 5
    end

  end

  describe 'GET #retrieve_letter' do

    it "should find specified letter and assign it to @letter" do
      login(user)
      xhr :get, :retrieve_letter, letter_id: letter, format: 'js'
      expect(assigns(:letter)).to eq letter
    end

  end

  describe 'GET #switch_workspace' do

    it "assigns specified workspace to @workspace" do
      login(user)
      xhr :get, :switch_workspace, workspace: "full_letter_workspace", :format => "js"
      expect(assigns(:workspace)).to eq "full_letter_workspace"
    end

    it "assigns all authors to @authors" do
      login(user)
      xhr :get, :switch_workspace, workspace: "full_letter_workspace", :format => "js"
      author = Author.find(letter.author_id)
      expect(assigns(:authors)).to eq [author]
    end

    context "full letter workspace" do

      it "assigns offset to 0" do
        login(user)
        xhr :get, :switch_workspace, workspace: "full_letter_workspace", :format => "js"
        expect(assigns(:offset)).to eq 0
      end

      it "assigns current letter to @current_letter" do
        login(user)
        xhr :get, :switch_workspace, workspace: "full_letter_workspace", :format => "js"
        expect(assigns(:current_letter)).to eq letter
      end

      it "assigns nil to @previous_letter" do
        login(user)
        xhr :get, :switch_workspace, workspace: "full_letter_workspace", :format => "js"
        expect(assigns(:previous_letter)).to eq nil
      end

      it "assigns next letter to @next_letter" do
        login(user)
        xhr :get, :switch_workspace, workspace: "full_letter_workspace", :format => "js"
        expect(assigns(:next_letter)).to eq letter
      end

    end

    context "snippet workspace" do

      it "assigns authors who have snippets to @authors" do
        login(user)
        xhr :get, :switch_workspace, workspace: "snippet_workspace", :format => "js"
        author.snippets << FactoryGirl.create(:snippet)
        expect(assigns(:authors)).to eq [author]
      end

      it "assigns a new letter to @current_letter" do
        login(user)
        xhr :get, :switch_workspace, workspace: "snippet_workspace", :format => "js"
        expect(assigns(:current_letter)).to eq Letter.last
      end

      it "creates the relationship between new letter and current user" do
        login(user)
        xhr :get, :switch_workspace, workspace: "snippet_workspace", :format => "js"
        expect(user.letters).to include Letter.last
      end

    end

    context "the else workspace" do

      it "assigns a new letter to @current_letter" do
        login(user)
        xhr :get, :switch_workspace, workspace: "", :format => "js"
        expect(assigns(:current_letter)).to be_a_new Letter
      end

    end

  end

  describe 'GET #create_with_quiz' do

    it "sets specified letter to @letter" do
      LettersController.any_instance.stub(:set_snippet).and_return(Snippet.create(content: 'here is the content'))
      login(user)
      xhr :post, :create_with_quiz, :question_1 =>"A", :question_2 => "B", :question_3 => "A", :question_4 => "B", :question_5 => "B", format: 'js'
      expect(assigns(:letter)).to eq Letter.last
    end

    it "builds letter out of snippets (in specified order) and saves it to letter as content" do
      LettersController.any_instance.stub(:set_snippet).and_return(Snippet.create(content: 'here is the content'))
      login(user)
      xhr :post, :create_with_quiz, :question_1 =>"A", :question_2 => "B", :question_3 => "A", :question_4 => "B", :question_5 => "B", format: 'js'
      letter = Letter.last
      expect(letter.content).to_not be nil
    end

    it "renders nothing" do
      LettersController.any_instance.stub(:set_snippet).and_return(Snippet.create(content: 'here is the content'))
      login(user)
      xhr :post, :create_with_quiz, :question_1 =>"A", :question_2 => "B", :question_3 => "A", :question_4 => "B", :question_5 => "B", format: 'js'
      response.should have_content("#")
    end

  end

  describe 'GET #create_with_snippet' do

    it "sets specified letter to @letter" do
      login(user)
      new_letter = Letter.create
      xhr :post, :create_with_snippet, :letter => { snippet_id: snippet.id, letter_id: new_letter.id }, format: 'js'
      expect(assigns(:letter)).to eq Letter.last
    end

    it "assigns specified snippet to @snippet" do
      login(user)
      new_letter = Letter.create
      xhr :post, :create_with_snippet, :letter => { snippet_id: snippet.id, letter_id: new_letter.id }, format: 'js'
      expect(assigns(:snippet)).to eq Snippet.last
    end

    it "creates a new LetterSnippet" do
      login(user)
      new_letter = Letter.create
      expect{
        xhr :post, :create_with_snippet, :letter => { snippet_id: snippet.id, letter_id: new_letter.id }, format: 'js'
      }.to change(LetterSnippet, :count).by(1)
      
    end

  end

end

    # @letter = Letter.find(params[:letter][:letter_id])
    # @snippet = Snippet.find(params[:letter][:snippet_id])
    # letter_snippet = LetterSnippet.new letter: @letter, snippet: @snippet, position: 1
    # letter_snippet.save

 #  def build_snippet_letter
 #    @letter = Letter.find(params[:letter_id])
 #    letter_content = ''
 #    @letter.snippets.by_position.each do |snippet|
 #      letter_content += " #{snippet.content}"
 #    end
 #    @letter.content = letter_content
 #    @letter.save
 #    render nothing: true
 #  end

 #  def build_quiz_letter(letter)
 #    letter_content = ''
 #    @letter.snippets.each do |snippet|
 #      letter_content += " #{snippet.content}"
 #    end
 #    @letter.content = letter_content
 #    @letter.save
 #  end

 #{"direction"=>"next", "offset"=>"1", "id"=>"2"}




