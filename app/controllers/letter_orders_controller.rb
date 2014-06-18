class LetterOrdersController < ApplicationController
  load_and_authorize_resource

  def create
    @letter_order = LetterOrder.new(letter_order_params)
    if @letter_order.save    
      redirect_to letter_order_path(@letter_order)
    else
      gflash notice: "There was a problem saving your order. Please try again"
      redirect_to :back
    end
  end

  def show
    @letter_order = LetterOrder.find(params[:id])
    @letter = Letter.find(@letter_order.letter_id)
    # pdf = Prawn::Document.new
    # pdf.text "Hello World"
    # x = pdf.render_file 'test.pdf'
       
    #deliver_as_snail_mail(@letter_order)

    respond_to do |format|
      format.html
      format.pdf do
        pdf = Prawn::Document.new
        pdf.text "Dearest #{@letter_order.recipient_name},"
        pdf.move_down 15
        pdf.text @letter.content
        pdf.move_down 15
        if @letter_order.custom_message.present?
          pdf.text @letter_order.custom_message
        end
        pdf.text "\nAll my love,\n"
        pdf.text "#{@letter_order.signature}"
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
      end
    end
  end

  def checkout
    @letter_order = LetterOrder.find(params[:id])
  end

  def charge_create
    ### ensure customer hasn't already paid for sending this letter to this particular person???
    @letter_order = LetterOrder.find(params[:id])
    Stripe.api_key = "sk_test_lkp40TChTNR5NT9iJJw6vuKh"

    token = params[:stripeToken]

    begin
      charge = Stripe::Charge.create(
        :amount => 200, # amount in cents, again
        :currency => "usd",
        :card => token,
        :description => "payinguser@example.com"
      )
    rescue Stripe::CardError => e
      gflash notice: "There was a problem with yoru card. Please try again. #{e.full_messages}"
      redirect_to :back
    end

    gflash notice: "Your card has been successfully charged. We're prepping your letter for sending right now!"
    deliver_as_snail_mail(@letter_order)
    redirect_to new_letter_path
  end

  # move to model
  def deliver_as_email
    @letter_order = LetterOrder.find(params[:id])
    letter = Letter.find(@letter_order.letter_id)
    LetterMailer.love_letter(current_user, letter, @letter_order).deliver
    gflash notice: "Your letter has been sent!"
    redirect_to root_path
  end


  # hook this up appropriately later
  def deliver_as_snail_mail(letter_order)
    @letter_order = letter_order
    @letter = Letter.find(@letter_order.letter_id)
    user = User.find(@letter_order.user_id)
    @lob = Lob(api_key: "test_54d506bcb9685853d7189ac266b7e173a1e") #change to ENV key
    response = @lob.jobs.create(
      name: "Inline Test Job",
      from: {
        name:    "#{user.name}",
        address_line1: "1106 Ahwenasa Trail",
        city:    "Macon",
        state:  "GA",
        country: "US",
        zip:    31220
      },
      to: {
        name:    @letter_order.recipient_name,
        address_line1: @letter_order.address_line_1,
        address_line2: @letter_order.address_line_2,
        city:    @letter_order.city,
        state:  @letter_order.state,
        country: "US",
        zip:    @letter_order.zip_code
      },
      objects: {
        name: "letter: #{@letter.id}",
        file:  "http://www.ub-careers.buffalo.edu/rsample1p.pdf", #in production, change to 'http://pacific-refuge-9865.herokuapp.com/letter_orders/#{letter_order.id}.pdf'
        setting_id: 100
    })
    #from response, save job order id to letter_order in database
  end

  def cancel
    @letter_order = LetterOrder.find(params[:id])
    @letter = Letter.find(@letter_order.letter_id)
    if @letter_order.delete && @letter.delete
      redirect_to new_letter_path
    else
      gflash notice: "Something went wrong. Try again or click a link in the navbar at the top of this page."
      redirect_to :back
    end
  end

  private

  def letter_order_params
    params.require(:letter_order).permit(:recipient_email, :recipient_name, :type, :signature, :letter_id, :user_id, :delivery_type, :address_line_1, :address_line_2, :city, :state, :zip_code, :custom_message)
  end
end