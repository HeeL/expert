class OrderMailer < ActionMailer::Base
  include ApplicationHelper

  default_url_options[:host] = ""

  def confirm(order)
    subject    "Заказ №#{order.id} принят!"
    recipients order.user.email
    from       'noreply.ekka@gmail.com'
    sent_on    Time.now
    body       :order=>order, :date=>to_russian_date(order.created_at), :name=>order.user.name
  end

  def inform(order, email)
    subject     "Поступил заказ №#{order.id}!"
    recipients  email
    from        'noreply.ekka@gmail.com'
    sent_on     Time.now

    body        :order=>order, :date=>to_russian_date(order.created_at)
  end

  def delivery(order_delivery, email, sent_at = Time.now)
    subject    "Запрос на доставку по заказу №#{order_delivery.order_id}!"
    recipients email
    from       'noreply.ekka@gmail.com'
    sent_on    sent_at

    body       :delivery=>order_delivery, :date=>to_russian_date(order_delivery.created_at)
  end


  def message(message, sent_at = Time.now)
    subject    "Новое сообщение по заказу №#{message.order.id}!"
    recipients message.order.user.email
    from       'noreply.ekka@gmail.com'
    sent_on    sent_at
    body       :message=>message, :order=>message.order, :date=>to_russian_date(message.created_at), :name=>message.order.user.name
  end


 def password_reset_instructions(user)
   subject       "Восстановление пароля"
   from          "noreply.ekka@gmail.com"
   recipients    user.email
   sent_on       Time.now
   body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
 end

end

