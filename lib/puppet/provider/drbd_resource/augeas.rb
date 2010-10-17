require 'augeas' rescue nil

Puppet::Type.type(:drbd_resource).provide(:augeas) do
  desc "Augeas support"

  confine :true => File.exists? "/usr/share/augeas/lenses/drbd.aug"

  def initialize(*args)
    super
    @aug = Augeas::open("/", "/usr/share/augeas/lenses", Augeas::NO_MODL_AUTOLOAD)
    @aug.transform(:lens => "Drbd.lns", :incl => "/etc/drbd.conf")
    @aug.load
    @context = "/files/etc/drbd.conf"
  end

  def flush
    @aug.save
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
