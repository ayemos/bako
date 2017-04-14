jd = job_definition 'hello_def' do
  type 'container'
end

job 'missing-queue' do
  job_definition jd
end
