describe UsersController do
  describe '#destroy' do
    context 'neither admin nor vip' do
      let!(:user) { FactoryBot.create(:user) }

      before do
        sign_in!
      end

      it 'does not allow the request' do
        expect {
          delete :destroy, params: { id: user.id }
        }.not_to change(User, :count)
      end
    end

    context 'vip' do
      let!(:user) { FactoryBot.create(:user) }

      before do
        sign_in!('vip')
      end

      it 'does not allow the request' do
        expect {
          delete :destroy, params: { id: user.id }
        }.not_to change(User, :count)
      end
    end

    context 'admin' do
      let!(:user) { FactoryBot.create(:user) }

      before do
        sign_in!('admin')
      end

      it 'allows the request' do
        expect {
          delete :destroy, params: { id: user.id }
        }.to change(User, :count).by(-1)
      end
    end
  end
end
