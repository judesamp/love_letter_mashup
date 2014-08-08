require 'spec_helper'

describe Snippet do

	describe "by position scope" do
		let(:letter) { FactoryGirl.create(:letter) }
		let(:snippet) { letter.snippets.create(FactoryGirl.attributes_for(:snippet)) }
		let(:snippet2) { letter.snippets.create(FactoryGirl.attributes_for(:snippet)) }


		it "should return snippets by position" do
			letter_snippet_1 = LetterSnippet.where(letter_id: letter.id).where(snippet_id: snippet.id).first
			letter_snippet_2 = LetterSnippet.where(letter_id: letter.id).where(snippet_id: snippet2.id).first
			letter_snippet_1.position = 2
			letter_snippet_1.save
			letter_snippet_2.position = 1
			letter_snippet_2.save
			expect(letter.snippets.by_position).to eq [snippet2, snippet]
		end

	end

end