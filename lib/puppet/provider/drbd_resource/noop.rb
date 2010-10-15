require 'augeas' rescue nil

class Augeas
  unless Augeas.public_methods.include? "three_arg_open"
    class << self
      alias_method :three_arg_open, :open
    end

    def self.open(root, search_path="", flags=0)
      three_arg_open(root, search_path, flags)
    end
  end
end

Puppet::Type.type(:drbd_resource).provide(:noop) do
  desc "Augeas support"

  confine :false, @aug.exists("/augeas/load/Drbd/lens")

  def initialize(*args)
    super
    @aug = Augeas.open("/")
  end

  def create
  end

  def destroy
  end

  def exists?
    resource[:ensure] == :present ? true : false
  end

  def protocol
    resource[:protocol]
  end

  def protocol=(value)
  end
end
