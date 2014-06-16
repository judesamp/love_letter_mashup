class SnippetsController < ApplicationController

	def create
		@snippet = Snippet.new(snippet_params)
		if @snippet.save
			gflash notice: "Snippet created!"
			redirect_to :back
		else
			gflash notice: "Something is amiss. Please try again!"
			redirect_to :back
		end
	end

	private

	def snippet_params
		params.require(:snippet).permit(:content, :author_id)
	end
end