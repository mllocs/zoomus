# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Zoom::Params do

  describe '#require' do
    let(:params) { Zoom::Params.new(foo: :bar)}
    it 'does not raise an error when required keys are present' do
      expect { params.require(:foo) }.not_to raise_error(Zoom::ParameterMissing)
    end

    it 'does raise an error when required keys are missing' do
      expect { params.require(:bar) }.to raise_error(Zoom::ParameterMissing, 'bar')
    end
  end

  describe '#permit' do
    let(:params) { Zoom::Params.new(foo: { bar: :baz })}

    it 'does not raise an error when permitted keys are present' do
      expect { params.require(:foo).permit(:bar) }.not_to raise_error(Zoom::ParameterNotPermitted)
    end

    it 'does not raise an error when permitted keys are not present' do
      expect { params.require(:foo).permit(:bar, :bang) }.not_to raise_error(Zoom::ParameterNotPermitted)
    end

    context 'raises an error' do
      let(:bad_params) { Zoom::Params.new(foo: { bar: :baz, bang: :boom }) }
      let(:other_bad_params) {
        Zoom::Params.new(foo: {
          bar: {
            baz: :bang,
            boom: :pow,
            asdf: :test,
            testerino: :other
          }
        })
      }
      let(:really_bad_params) { Zoom::Params.new(foo: {
        bar: {
          baz: {
            bang: {
              nested: true,
              this: :thing,
              is: [:very, :deep],
              bad_param: :asdf
            }
          }
        }
      }) }
      it 'when non-permitted keys are present' do
        expect { bad_params.require(:foo).permit(:bar) }.to raise_error(Zoom::ParameterNotPermitted, [:bang].to_s)
      end

      it 'when nested non-permitted keys are present' do
        expect { other_bad_params.require(:foo).permit(bar: [:baz, :boom])}.to raise_error(Zoom::ParameterNotPermitted, [:asdf, :testerino].to_s)
      end

      it 'when deeply nested non-permitted keys are present' do
        expect { really_bad_params.require(:foo).permit(bar: { baz: {bang: [:nested, :this, :is] } }) }.to raise_error(Zoom::ParameterNotPermitted, [:bad_param].to_s)
      end
    end
  end
end