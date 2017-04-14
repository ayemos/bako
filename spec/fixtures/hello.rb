jd = job_definition 'hello_def' do
  type 'container'
end

job 'hello' do
  job_definition jd
  job_queue 'hello-queue'
  command ['echo', 'hello']
  param({foo: 'bar'})
  memory 256
  vcpus 4
end
