require "test_helper"

class OderMailerTest < ActionMailer::TestCase
  test "received" do
    mail = OderMailer.received(orders(:one))
    assert_equal "Pragmatic Store Order Confirmation", mail.subject
    assert_equal [ "dave@example.org" ], mail.to
    assert_equal [ "depot@example.com" ], mail.from
    assert_match /1 x Pragmatic Programmer/, mail.body.encoded
  end

  test "shipped" do
    mail = OderMailer.shipped(orders(:one))
    assert_equal "Pragmatic Store Order Shipped", mail.subject
    assert_equal [ "dave@example.org" ], mail.to
    assert_equal [ "depot@example.com" ], mail.from
    assert_match %r{
      <td[^>]*>1<\/td<\s*
      <td>&time;<\/td>\s*
      <td>[^>]*>\s*The\sPragmatic\sProgrammer\s*<\/td>
    }x, mail.body.encoded
  end
end
