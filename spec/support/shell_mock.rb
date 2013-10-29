# Raised when shell operations are invoked
class ShellNotAllowedError < StandardError

  def initialize(command)
    msg =  "Shell operation is not allowed: #{command}\n\n"
    msg << "You can stub this request with the following snippet:\n\n"
    msg << "stub_shell(\"#{command}\", :output => '', :exitstatus => 0)\n "
    super msg
  end

end

# Prevent invoking shell operations
class Object

  def `(command)
    raise ShellNotAllowedError, command
  end

  def system(command)
    raise ShellNotAllowedError, command
  end

  # Stubs shell operations matching given command
  #
  # Options:
  #   :output     (defaults to '')
  #   :exitstatus (defaults to 0)
  #
  def stub_shell(command, options = {})
    output = options.delete(:output) || ''
    exitstatus = options.delete(:exitstatus) || 0

    block = lambda {
      if exitstatus.nonzero?
        Kernel.send :`, "test"
      else
        Kernel.send :`, "test success"
      end
      output
    }

    stub(:`).with(command).and_return &block
    stub(:system).with(command).and_return &block
  end

end
