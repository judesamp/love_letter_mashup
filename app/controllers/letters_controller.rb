class LettersController < ApplicationController

  def index
    @letters = current_user.letters.all
  end

  def show
    @offset = params[:offset].to_i
    @direction = params[:direction]
    @current_letter = Letter.limit(1).offset(@offset).first
    @next_letter = Letter.limit(1).offset(@offset + 1).first
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

  def switch_workspace
    @workspace = params[:workspace]
    @authors = Author.all
    @images = ['Book.png', 'Communication.png', 'Compass.png', 'Cut.png', 'Download.png', 'Envelope.png', 'Eye.png', 'Hourglass.png', 'Key.png', 'Lighthouse.png', 'Locator.png', 'map_with_locator.png', 'Mountain.png', 'Note.png', 'Pencil.png', 'Picture.png', 'Search.png', 'sound_wave.png', 'Volume.png']
    if @workspace == "full_letter_workspace"
      @offset = 0
      @current_letter = Letter.first
      @previous_letter = nil
      @next_letter = Letter.limit(1).offset(0)[0]
    end
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