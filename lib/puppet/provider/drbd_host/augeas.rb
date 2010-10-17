require 'augeas' rescue nil

Puppet::Type.type(:drbd_host).provide(:augeas) do
  desc "Augeas support"

  confine :true => File.exists? "/usr/share/augeas/lenses/drbd.aug"

  def initialize(*args)
    super
    @aug = Augeas::open("/", "/usr/share/augeas/lenses", Augeas::NO_MODL_AUTOLOAD)
    @aug.transform(:lens => "Drbd.lns", :incl => "/etc/drbd.conf")
    @aug.load
    @context = "/files/etc/drbd.conf/#{resource[:resource]}"
  end

  def flush
    @aug.save
  end

  def create
    @aug.set("#{@context}/#{resource[:hostname]}/address", resource[:address])
    @aug.set("#{@context}/#{resource[:hostname]}/disk", resource[:disk])
    @aug.set("#{@context}/#{resource[:hostname]}/device", resource[:device])

    unless resource[:meta_disk].nil?
      @aug.set("#{@context}/#{resource[:hostname]}/meta-disk", resource[:meta_disk])
    else
      @aug.set("#{@context}/#{resource[:hostname]}/flexible-meta-disk", resource[:flexible_meta_disk])
    end
  end

  def destroy
    @aug.rm("#{@context}/#{resource[:hostname]}")
  end

  def exists?
    @aug.exists("#{@context}/#{resource[:hostname]}")
  end

  def device
    @aug.get("#{@context}/#{resource[:hostname]}/device")
  end

  def device=(value)
    if value.nil?
      @aug.rm("#{@context}/#{resource[:hostname]}/device")
    else
      @aug.set("#{@context}/#{resource[:hostname]}/device", value)
    end
  end

  def disk
    @aug.get("#{@context}/#{resource[:hostname]}/disk")
  end

  def disk=(value)
    if value.nil?
      @aug.rm("#{@context}/#{resource[:hostname]}/disk")
    else
      @aug.set("#{@context}/#{resource[:hostname]}/disk", value)
    end
  end

  def address
    @aug.get("#{@context}/#{resource[:hostname]}/address")
  end

  def address=(value)
    if value.nil?
      @aug.rm("#{@context}/#{resource[:hostname]}/address")
    else
      @aug.set("#{@context}/#{resource[:hostname]}/address", value)
    end
  end

  def meta_disk
    @aug.get("#{@context}/#{resource[:hostname]}/meta-disk")
  end

  def meta_disk=(value)
    if value.nil?
      @aug.rm("#{@context}/#{resource[:hostname]}/meta-disk")
    else
      @aug.set("#{@context}/#{resource[:hostname]}/meta-disk", value)
    end
  end

  def flexible_meta_disk
    @aug.get("#{@context}/#{resource[:hostname]}/flexible-meta-disk")
  end

  def flexible_meta_disk=(value)
    if value.nil?
      @aug.rm("#{@context}/#{resource[:hostname]}/flexible-meta-disk")
    else
      @aug.set("#{@context}/#{resource[:hostname]}/flexible-meta-disk", value)
    end
  end
end
