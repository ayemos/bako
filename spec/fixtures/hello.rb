job 'hello' do
  job_queue 'hello-queue'
  command ['echo', 'hello']
  param({foo: 'bar'})
  memory 256
  vcpus 4
end
