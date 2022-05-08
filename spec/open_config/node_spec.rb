# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OpenConfig::Node do
  def node(hash)
    described_class.new(hash)
  end

  subject do
    node(
      top: 'Top String',
      node: node(
        string: 'Node String',
        integer: 123,
        float: 1.23,
        boolean: false,
        nested_node: node(
          array: [
            'First Element',
            'Second Element',
          ],
        )
      )
    )
  end

  describe 'fields access' do
    describe 'reading' do
      describe 'by method calls' do
        context 'when key is known' do
          it { expect(subject.node.string).to eq('Node String') }
        end

        context 'when key is unknown' do
          it { expect(subject.unknown).to eq(nil) }
        end
      end

      describe '#[]' do
        context 'when key is known' do
          context 'with symbols' do
            it { expect(subject[:node][:string]).to eq('Node String') }
          end

          context 'with strings' do
            it { expect(subject['node']['string']).to eq('Node String') }
          end
        end

        context 'when key is unknown' do
          it { expect(subject[:unknown]).to eq(nil) }
        end
      end

      describe '#dig' do
        context 'when key is known' do
          it { expect(subject.dig(:node, :string)).to eq('Node String') }
        end

        context 'when key is unknown' do
          it { expect(subject.dig(:unknown, :string)).to eq(nil) }
        end
      end

      describe '#fetch' do
        context 'when key is known' do
          it { expect(subject.fetch(:top)).to eq('Top String') }
          it { expect(subject.fetch('top')).to eq('Top String') }
        end

        context 'when key is unknown' do
          context 'when fallback is provided' do
            let(:fallback) { SecureRandom.hex }

            it { expect(subject.fetch(:unknown, fallback)).to eq(fallback) }
            it { expect(subject.fetch('unknown', fallback)).to eq(fallback) }

            it { expect(subject.fetch(:unknown) { fallback }).to eq(fallback) }
            it { expect(subject.fetch('unknown') { fallback }).to eq(fallback) }
          end

          context 'when fallback is not provided' do
            it { expect { subject.fetch(:unknown) }.to raise_error(KeyError) }
            it { expect { subject.fetch('unknown') }.to raise_error(KeyError) }
          end
        end
      end
    end

    describe 'writing' do
      let(:another_string) { SecureRandom.hex }

      describe 'by method calls' do
        it 'stores updates' do
          expect { subject.node.string = another_string }
            .to change { subject.node.string }
            .from('Node String')
            .to(another_string)
        end
      end

      describe '#[]=' do
        context 'with symbols' do
          it 'stores updates' do
            expect { subject.node[:string] = another_string }
              .to change { subject.node.string }
              .from('Node String')
              .to(another_string)
          end
        end

        context 'with strings' do
          it 'stores updates' do
            expect { subject.node['string'] = another_string }
              .to change { subject.node.string }
              .from('Node String')
              .to(another_string)
          end
        end
      end
    end
  end

  describe '#to_h' do
    it 'deeply casts node to hash' do
      expect(subject.to_h).to eq(
        {
          top: 'Top String',
          node: {
            string: 'Node String',
            integer: 123,
            float: 1.23,
            boolean: false,
            nested_node: {
              array: [
                'First Element',
                'Second Element',
              ],
            }
          }
        }
      )
    end
  end

  describe '#==' do
    let(:another_subject) do
      node(
        top: 'Top String',
        node: node(
          string: 'Node String',
          integer: 123,
          float: 1.23,
          boolean: false,
          nested_node: node(
            array: [
              'First Element',
              'Second Element',
            ],
          )
        )
      )
    end

    context 'when configs are the same' do
      it { expect(subject).to eq(another_subject) }
    end

    context 'when configs are not the same' do
      before do
        another_subject.node.string = SecureRandom.hex
      end

      it { expect(subject).not_to eq(another_subject) }
    end
  end
end
