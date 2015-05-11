class ContactsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    render json: user.contacts + user.shared_contacts
  end

  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact
    else
      render json(
        contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def update
    contact = Contact.find(params[:id])
    if contact.update_attributes(contact_params)
      render json: contact
    else
      render json(
        contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
    render json: contact
  end

  def show
    render json: Contact.find(params[:id])
  end

  private

  def contact_params
    params.require(:contact).permit(:user_id, :name, :email)
  end
end
