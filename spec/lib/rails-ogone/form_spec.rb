require 'rails-ogone'

describe RailsOgone::Form do
  subject { described_class.new }

  it '#input' do
    expect(subject.input('hidden', 'foo', 'bar')).to eq '<input type="hidden" name="FOO" value="bar" />'
  end

  describe '#action_url' do
    describe 'prod' do
      subject { described_class.new 'production' }

      it 'iso' do
        expect(subject.action_url).to eq 'https://secure.ogone.com/ncol/prod/orderstandard.asp'
      end

      it 'utf8' do
        expect(subject.action_url(utf8: true)).to eq 'https://secure.ogone.com/ncol/prod/orderstandard_utf8.asp'
      end
    end

    describe 'test' do
      it 'iso' do
        expect(subject.action_url).to eq 'https://secure.ogone.com/ncol/test/orderstandard.asp'
      end

      it 'utf8' do
        expect(subject.action_url(utf8: true)).to eq 'https://secure.ogone.com/ncol/test/orderstandard_utf8.asp'
      end
    end
  end

  describe '#tag' do
    it :prod do
      subject = described_class.new('production')
      expect(subject.tag).to eq '<form method="post" action="https://secure.ogone.com/ncol/prod/orderstandard.asp">'
    end

    it :test do
      expect(subject.tag).to eq '<form method="post" action="https://secure.ogone.com/ncol/test/orderstandard.asp">'
    end

    it :parameters do
      expect(subject.tag(class: 'test')).to eq '<form method="post" class="test" action="https://secure.ogone.com/ncol/test/orderstandard.asp">'
    end
  end

  it '#respond_to?' do
    expect(subject).to respond_to(:input, :action_url, :tag)
  end
end
