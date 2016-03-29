# In this semi-fictionalised version of the BiggerPockets Store, we are selling
# one of our real estate investing education books and tickets to our
# conference. We are constantly trying to expand to offer our products
# to new markets around the world, so we continually need to add support
# for different payment gateways and methods. Also, as the company grows,
# we plan to bring new sales and marketing staff on board who will need to
# see order data in various formats (HTML, XML, etc.). Additionally, we are
# planning to introduce a lot of new products into the store very soon, such as
# software and training seminars.

# write a class for software
class Software
  def initialize(type, quantity)
    @software_type = type
    @software_quantity = quantity
  end
end

# write a class for training seminars
class TrainingSeminar
  def initialize(type, tickets)
    @seminar_type = type
    @seminar_tickets = tickets
  end
end

class BookOrder
  def initialize(order_number, quantity, address)
    @order_number = order_number
    @quantity = quantity
    @address = address
  end

  def charge(order_type, payment_type)
    if order_type == "ebook"
      shipping = 0
    else
      shipping = 5.99
    end

    if payment_type == :cash
      send_email_receipt
      @status = "charged"
    elsif payment_type == :cheque
      send_email_receipt
      @status = "charged"
    elsif payment_type == :paypal
      if charge_paypal_account(shipping + (quantity * 14.95))
        send_email_receipt
        @status = "charged"
      else
        send_payment_failure_email
        @status = "failed"
      end
    elsif payment_type == :stripe
      if charge_credit_card(shipping + (quantity * 14.95))
        send_email_receipt
        @status = "charged"
      else
        send_payment_failure_email
        @status = "failed"
      end
    end
  end

  def ship(order_type)
    if order_type == "ebook"
      # [send email with download link...]
    else
      # [print shipping label]
    end

    @status = "shipped"
  end

  def quantity
    @quantity
  end

  def status
    @status
  end

  def to_s(order_type)
    if order_type == "ebook"
      shipping = 0
    else
      shipping = 4.99
    end
    report = "Order ##{@order_number}\n"
    report += "Ship to: #{@address.join(", ")}\n"
    report += "-----\n\n"
    report += "Qty   | Item Name                       | Total\n"
    report += "------|---------------------------------|------\n"
    report += "#{@quantity}     | Book                            | $#{shipping + (quantity * 14.95)}"
    report
    return report
  end

  def shipping_cost(order_type)
    if order_type == "ebook"
      shipping = 0
    else
      shipping = 4.95
    end
  end

  def send_email_receipt
    # [send email receipt]
  end

  # In real life, charges would happen here. For sake of this test, it simply returns true
  def charge_paypal_account(amount)
    true
  end

  # In real life, charges would happen here. For sake of this test, it simply returns true
  def charge_credit_card(amount)
    true
  end
end

class ConferenceTicketOrder
  def initialize(order_number, quantity, address)
    @order_number = order_number
    @quantity = quantity
    if quantity > 1
      raise 'Conference tickets are limited to one per customer'
    end
    @address = address
  end

  # logic to see if quantity if > 1 and, if so, throw this error:
  # "Conference tickets are limited to one per customer"

  def charge(payment_type)
    shipping = 0
    if payment_type == :cash
      send_email_receipt
      @status = "charged"
    elsif payment_type == :cheque
      send_email_receipt
      @status = "charged"
    elsif payment_type == :paypal
      charge_paypal_account shipping + (quantity * 300)
      send_email_receipt
      @status = "charged"
    elsif payment_type == :stripe
      charge_credit_card shipping + (quantity * 300)
      send_email_receipt
      @status = "charged"
    end
  end

  def ship
    # [print ticket]
    # [print shipping label]

    @status = "shipped"
  end

  def quantity
    @quantity
  end

  def status
    @status
  end

  require 'action_view'
  include ActionView::Helpers::NumberHelper

  def to_s
    shipping = 0
    report = "Order ##{@order_number}\n"
    report += "Ship to: #{@address.join(", ")}\n"
    report += "-----\n\n"
    report += "Qty   | Item Name                       | Total\n"
    report += "------|---------------------------------|------\n"
    report += "#{@quantity}     |"
    report += " Conference Ticket               |"
    report += " $#{number_with_precision(shipping + (quantity * 300), precision: 2)}"
    report
    return report
  end

  def shipping_cost
    shipping = 0
  end

  def send_email_receipt
    # [send email receipt]
  end

  # In real life, charges would happen here. For sake of this test, it simply returns true
  def charge_paypal_account(amount)
    true
  end

  # In real life, charges would happen here. For sake of this test, it simply returns true
  def charge_credit_card(amount)
    true
  end
end
