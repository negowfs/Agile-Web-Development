# Preview all emails at http://localhost:3000/rails/mailers/oder_mailer
class OderMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/oder_mailer/received
  def received
    OderMailer.received
  end

  # Preview this email at http://localhost:3000/rails/mailers/oder_mailer/shipped
  def shipped
    OderMailer.shipped
  end
end
