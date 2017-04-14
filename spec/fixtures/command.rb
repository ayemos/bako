job 'command_1' do
  job_queue 'command-queue'
  command ['echo', 'hello']
end

job 'command_2' do
  job_queue 'command-queue'
  command 'echo hello'
end
