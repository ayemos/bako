preproc_jd = job_definition 'preproc-inception' do
  command ['sleep', '10']
  type 'container'
  image 'busybox'
end

preproc_jobs = []

[*1..2].each do |i|
  preproc_job = job "preproc-inception-#{i}" do
    job_definition preproc_jd
    job_queue 'bako-test-queue-001'

    param({
      foo: 'bar'
    })
  end

  preproc_jobs << preproc_job
end

train_jd = job_definition 'train-inception' do
  command ['python', '/tensorflow/tensorflow/examples/learn/mnist.py']
  type 'container'
  memory 1024
  vcpus 4
  image 'tensorflow/tensorflow:latest-devel'
end

job 'train-inception' do
  job_definition train_jd
  job_queue 'bako-test-queue-001'
  depends_on preproc_jobs
end
