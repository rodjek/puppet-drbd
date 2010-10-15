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

Puppet::Type.type(:drbd_host).provide(:augeas) do
  desc "Augeas support"

  def initialize(*args)
    super
    @aug = Augeas.open("/files/etc/drbd.conf/#{resource[:resource]}")
  end

  def create
    @aug.set("#{resource[:hostname]}/address", should(:address))
    @aug.set("#{resource[:hostname]}/disk", should(:disk))
    @aug.set("#{resource[:hostname]}/device", should(:device))

    unless should(:meta_disk).nil?
      @aug.set("#{resource[:hostname]}/meta-disk", should(:meta_disk))
    else
      @aug.set("#{resource[:hostname]}/flexible-meta-disk", should(:flexible_meta_disk))
    end
  end

  def destroy
    @aug.rm(resource[:hostname])
  end

  def exists?
    @aug.exists(resource[:hostname])
  end

  def device
    @aug.get("#{resource[:hostname]}/device")
  end

  def device=(value)
    if value.nil?
      @aug.rm("#{resource[:hostname]}/device")
    else
      @aug.set("#{resource[:hostname]}/device", value)
    end
  end

  def disk
    @aug.get("#{resource[:hostname]}/disk")
  end

  def disk=(value)
    if value.nil?
      @aug.rm("#{resource[:hostname]}/disk")
    else
      @aug.set("#{resource[:hostname]}/disk", value)
    end
  end

  def address
    @aug.get("#{resource[:hostname]}/address")
  end

  def address=(value)
    if value.nil?
      @aug.rm("#{resource[:hostname]}/address")
    else
      @aug.set("#{resource[:hostname]}/address", value)
    end
  end

  def meta_disk
    @aug.get("#{resource[:hostname]}/meta-disk")
  end

  def meta_disk=(value)
    if value.nil?
      @aug.rm("#{resource[:hostname]}/meta-disk")
    else
      @aug.set("#{resource[:hostname]}/meta-disk", value)
    end
  end

  def flexible_meta_disk
    @aug.get("#{resource[:hostname]}/flexible-meta-disk")
  end

  def flexible_meta_disk=(value)
    if value.nil?
      @aug.rm("#{resource[:hostname]}/flexible-meta-disk")
    else
      @aug.set("#{resource[:hostname]}/flexible-meta-disk", value)
    end
  end
end
