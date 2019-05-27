class MinQtyMailer < ApplicationMailer
  def notice(admin, item)
    @item = item
    @name = admin.admin_full_name

    mail to: admin.email, subject: 'Notification on Item Quantity'
  end
end
