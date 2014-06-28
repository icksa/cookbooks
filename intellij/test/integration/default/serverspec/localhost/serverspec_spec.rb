require 'spec_helper'

describe 'Intellij Installation' do
  
  it 'should ensure that java 7 is installed' do
    expect(command 'java -version').to return_stdout /1\.7\.0/
  end

  it 'should install intellij files' do
    expect(file '/opt/ideaIU').to be_directory
  end

  it 'should make intellij available in default path' do
    expect(command 'which ijult').to return_stdout /ijult/
    @result = system("ijult")
    puts "BEFORE @result = #{@result}"
    expect(@result).not_to be_nil
  end

end
