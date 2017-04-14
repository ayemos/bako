jd = job_definition 'hello_def' do
  type 'container'
end

job 'command_space' do
  job_definition jd
  job_queue 'command-queue'
  command 'echo hello'
end

job 'command_int' do
  job_definition jd
  job_queue 'command-queue'
  command ['sleep', 10]
end
