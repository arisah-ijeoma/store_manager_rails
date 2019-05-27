# frozen_string_literal: true

describe MinQtyMailer, type: :mailer do
  describe '.notice' do
    let(:item) { create(:item, quantity: 1) }
    let(:admin) { create(:admin_user) }
    let(:mail) { described_class.notice(admin, item).deliver_now }

    it 'renders the subject' do
      expect(mail.subject).to eq('Notification on Item Quantity')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([admin.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['noreply@jaysgroup.com'])
    end

    it 'assigns @name' do
      expect(mail.body.encoded).to match(admin.admin_full_name)
    end

    it 'assigns @item_url' do
      expect(mail.body.encoded).to match(add_stock_admin_item_url(item))
    end
  end
end
