Thread.start {
  def sout = new StringBuilder(), serr = new StringBuilder()

  def generateKeys = [
    'ssh-keygen',
    '-t',
    'rsa',
    '-N',
    '',
    '-f',
    '/var/jenkins_home/.ssh/id_rsa'
  ].execute()

  generateKeys.waitForOrKill(1000)

  def runJimmy = 'jimmy -c /etc/jimmy/jimmy.yaml'.execute()
  runJimmy.consumeProcessOutput(sout, serr)
  runJimmy.waitForOrKill(100000)
  println "out> $sout"
  println "err> $serr"
}
