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

Puppet::Type.type(:drbd_resource).provide(:augeas) do
  desc "Augeas support"

  confine :true, @aug.exists("/augeas/load/Drbd/lens")

  def initialize(*args)
    super
    @aug = Augeas.open("/")
    @context = "/files/etc/drbd.conf"
  end

  def create
    @aug.set("#{@context}/#{resource[:name]}/protocol", resource[:protocol])
  end

  def destroy
    @aug.rm("#{@context}/#{resource[:name]}")
  end

  def exists?
    @aug.exists("#{@context}/#{resource[:name]}")
  end

  def protocol
    @aug.get("#{@context}/#{resource[:name]}/protocol")
  end

  def protocol=(value)
    @aug.set("#{@context}/#{resource[:name]}/protocol", value)
  end
end
