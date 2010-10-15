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

Puppet::Type.type(:drbd_host).provide(:noop) do
  desc "Dummy provider to be used on the Puppet runs before the DRBD " +
       "Augeas lens is installed."

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

  def device
    resource[:device]
  end

  def device=(value)
  end

  def disk
    resource[:disk]
  end

  def disk=(value)
  end

  def address
    resource[:address]
  end

  def address=(value)
  end

  def meta_disk
    resource[:meta_disk]
  end

  def meta_disk=(value)
  end

  def flexible_meta_disk
    resource[:flexible_meta_disk]
  end

  def flexible_meta_disk=(value)
  end
end
