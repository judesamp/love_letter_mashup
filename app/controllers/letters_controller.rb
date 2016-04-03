
class LettersController < ApplicationController
  load_and_authorize_resource
  layout 'workspace'

  def index
    @letters = current_user.letters.where("content is Not NULL")
  end

  def show
    @offset = params[:offset].to_i
    @direction = params[:direction]
    @current_letter = Letter.where("author_id is Not NULL").limit(1).offset(@offset).first
    @next_letter = Letter.where("author_id is Not NULL").limit(1).offset(@offset + 1).first
    @current_user_id = current_user.id.to_s
    @current_letter_id = @current_letter.id.to_s

    if @offset == 0
      @previous_letter = nil
    else
      @previous_letter = Letter.limit(1).offset(@offset - 1).first
    end
  end

  def create
    @letter = Letter.new(letter_params)
    if @letter.save
      gflash notice: "Your letter has been created successfully!"
      redirect_to :back
    else
      gflash notice: "Something went wrong tryign to save your letter. Please try again."
      redirect_to :back
    end
  end

  def create_with_snippet
    @letter = Letter.find(params[:letter][:letter_id])
    @snippet = Snippet.find(params[:letter][:snippet_id])
    letter_snippet = LetterSnippet.new letter: @letter, snippet: @snippet, position: 1
    letter_snippet.save
  end

  def add_or_subtract_snippet
    letter_id = params[:letter_id].to_i
    snippet_id = params[:snippet][:snippet_id].to_i
    @snippet = Snippet.find(snippet_id)
    if params[:snippet][:checked] == "false"
      @letter = Letter.find(letter_id)
      snippet_count = @letter.snippets.count
      letter_snippet = LetterSnippet.new letter: @letter, snippet: @snippet, position: snippet_count + 1
      letter_snippet.save
    else
      @letter = Letter.find(letter_id)
      @letter.snippets.delete(@snippet)
      @letter.save
    end
  end

  def update_positions
    JSON.parse(params[:Activity]).each_with_index do |incoming_data, index|
      letter_id = incoming_data['letter_id']
      snippet_id = incoming_data["snippet_id"]
      position = incoming_data["position"]
      letter_snippet = LetterSnippet.where("letter_id = ? AND snippet_id = ?", letter_id, snippet_id).first
      letter_snippet.position = position
      letter_snippet.save
    end
  end

  def create_with_quiz
    @letter = Letter.create
    current_user.save
    process_question_return_snippet(1, params[:question_1], @letter)
    process_question_return_snippet(2, params[:question_2], @letter)
    process_question_return_snippet(3, params[:question_3], @letter)
    process_question_return_snippet(4, params[:question_4], @letter)
    process_question_return_snippet(5, params[:question_5], @letter)
    build_quiz_letter(@letter)
  end

  def process_question_return_snippet(question, answer, letter)
    case question
    when 1
      if answer == "A"
        snippet = set_snippet(letter)
      elsif answer == "B"
        snippet = set_snippet(letter)
      else
      end
    when 2
      if answer == "A"
        snippet = set_snippet(letter)
      elsif answer == "B"
        snippet = set_snippet(letter)
      else
        snippet = set_snippet(letter)
      end
    when 3
      if answer == "A"
        snippet = set_snippet(letter)
      elsif answer == "B"
        snippet = set_snippet(letter)
      else
        snippet = set_snippet(letter)
      end
    when 4
      if answer == "A"
        snippet = set_snippet(letter)
      elsif answer == "B"
        snippet = set_snippet(letter)
      else
        snippet = set_snippet(letter)
      end
    else
      if answer == "A"
        snippet = set_snippet(letter)
      elsif answer == "B"
        snippet = set_snippet(letter)
      else
        snippet = set_snippet(letter)
      end
    end
  end

  def retrieve_letter
    @letter = Letter.find(params[:letter_id])
  end

  def switch_workspace
    @workspace = params[:workspace]
    @authors = Author.all
    @images = ['Book.png', 'Communication.png', 'Compass.png', 'Cut.png', 'Download.png', 'Envelope.png', 'Eye.png', 'Hourglass.png', 'Key.png', 'Lighthouse.png', 'Locator.png', 'map_with_locator.png', 'Mountain.png', 'Note.png', 'Pencil.png', 'Picture.png', 'Search.png', 'sound_wave.png', 'Volume.png']
    if @workspace == "full_letter_workspace"
      @offset = 0
      @current_letter = Letter.where("author_id is Not NULL").first
      @previous_letter = nil
      @next_letter = Letter.where("author_id is Not NULL").limit(1).offset(0)[0]
    elsif @workspace == "snippet_workspace"
      @authors = Author.joins(:snippets).where('snippets is not null').uniq
      @current_letter = Letter.create
    else
      @current_letter = Letter.new
    end
  end

  def set_snippet(letter)
    snippet = nil
    loop do
      snippet = Snippet.all.sample
      break unless letter.snippets.include? snippet 
    end
    snippet
  end

  def build_snippet_letter
    @letter = Letter.find(params[:letter_id])
    letter_content = ''
    @letter.snippets.by_position.each do |snippet|
      letter_content += " #{snippet.content}"
    end
    @letter.content = letter_content
    @letter.save
    render nothing: true
  end

  def build_quiz_letter(letter)
    letter_content = ''
    @letter.snippets.each do |snippet|
      letter_content += " #{snippet.content}"
    end
    @letter.content = letter_content
    @letter.save
  end


  # add delete functionality if user clicks on fade/close (rather than submitting next form)
  # def add_to_user
  #   @letter = Letter.find(params[:letter_id])
  #   @user = User.find(params[:letter][:user_id])
  #   @user.letters << @letter
  #   if @user.save
  #     render plain: "1"
  #   else
  #     render plain: "0"
  #   end
  # end

  private

  def letter_params 
    params.require(:letter).permit(:content, :author_id, :user_id)
  end

end