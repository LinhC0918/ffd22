class OrderMailer < ApplicationMailer
  def change_status order
    @order = order
    mail to: @order.user.email, subject: "Updated Order Status"
  end
end
