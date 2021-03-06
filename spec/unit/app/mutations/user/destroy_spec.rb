require 'spec_helper'

describe User::Destroy do
  let(:user) do
    create(:user)
  end

  let(:action) do
    User::Destroy.run({:user => { :id => user.id.to_s }})
  end

  it { action.success?.should be_true }
end
