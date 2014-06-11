class AuthorsController < ApplicationController

  def create
    @author =  Author.new(author_params)
    if @author.save
      gflash notice: "Author created successfully."
      redirect_to :back
    else
      gflash notice: "Something went wrong in the author creation process. Please try again."
      redirect_to :back
    end
  end

  private

  def author_params
    params.require(:author).permit(:first_name, :last_name, :bio, :author_image)
  end

end
