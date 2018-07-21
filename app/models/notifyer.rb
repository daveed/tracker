class Notifyer
  attr_accessor :body

  FROM = ENV.fetch('TWILIO_PHONE_NUMBER_FROM')
  TO   = ENV.fetch('TWILIO_PHONE_NUMBER_TO')

  def initialize(message)
    @body = message
    @from = FROM
    @to   = TO
  end

  def notify
    return unless @from && @to
    client.api.account.messages.create(from: @from, to: @to, body: @body)
  end

  private

  def client
    Twilio::REST::Client.new
  end
end
