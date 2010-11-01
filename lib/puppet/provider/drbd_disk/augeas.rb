require 'augeas' rescue nil

Puppet::Type.type(:drbd_disk).provide(:augeas) do
  desc "Augeas support"

  confine :true => File.exists? "/usr/share/augeas/lenses/drbd.aug"

  def initialize(*args)
    super
    @aug = Augeas::open('/', '/usr/share/augeas/lenses', Augeas::NO_MODL_AUTOLOAD)
    @aug.transform(:lens => "Drbd.lns", :incl => "/etc/drbd.conf")
    @aug.load
    @context = "/augeas/files/etc/drbd.conf/#{resource[:resource]}"
  end

  def flush
    @aug.save
  end

  def create
    @aug.insert(@context, "disk", false)
    self.on_io_error = resource[:on_io_error] unless resource[:on_io_error].nil?
    self.size = resource[:size] unless resource[:size].nil?
    self.fencing = resource[:fencing] unless resource[:fencing].nil?
    self.use_bmbv = resource[:use_bmbv] unless resource[:use_bmbv].nil?
    self.no_disk_flushes = resource[:no_disk_flushes] unless resource[:no_disk_flushes].nil?
    self.no_disk_barrier = resource[:no_disk_barrier] unless resource[:no_disk_barrier].nil?
    self.no_disk_drain = resource[:no_disk_drain] unless resource[:no_disk_drain].nil?
    self.no_md_flushes = resource[:no_md_flushes] unless resource[:no_md_flushes].nil?
    self.max_bio_bvecs = resource[:max_bio_bvecs] unless resource[:max_bio_bvecs].nil?
  end

  def destroy
    @aug.rm(@context)
  end

  def exists?
    @aug.exists?("#{@context}/disk")
  end

  def on_io_error
    @aug.get("#{@context}/disk/on-io-error")
  end

  def on_io_error=(value)
    if value.nil?
      @aug.rm("#{@context}/disk/on-io-error")
    else
      @aug.set("#{@context}/disk/on-io-error", value.to_s)
    end
  end

  def size
    @aug.get("#{@context}/disk/size")
  end

  def size=(value)
    if value.nil?
      @aug.rm("#{@context}/disk/size")
    else
      @aug.set("#{@context}/disk/size", value.to_s)
    end
  end

  def fencing
    @aug.get("#{@context}/disk/fencing")
  end

  def fencing=(value)
    if value.nil?
      @aug.rm("#{@context}/disk/fencing")
    else
      @aug.set("#{@context}/disk/fencing", value.to_s)
    end
  end

  def use_bmbv
    @aug.exists("#{@context}/disk/use-bmbv") ? :true : :false
  end

  def use_bmbv=(value)
    if value == :true
      @aug.insert("#{@context}/disk", "use-bmbv", false)
    else
      @aug.rm("#{@context}/disk/use-bmbv")
    end
  end

  def no_disk_flushes
    @aug.exists("#{@context}/disk/no-disk-flushes") ? :true : :false
  end

  def no_disk_flushes=(value)
    if value == :true
      @aug.insert("#{@context}/disk", "no-disk-flushes", false)
    else
      @aug.rm("#{@context}/disk/no-disk-flushes")
    end
  end

  def no_disk_barrier
    @aug.exists("#{@context}/disk/no-disk-barrier") ? :true : :false
  end

  def no_disk_barrier=(value)
    if value == :true
      @aug.insert("#{@context}/disk", "no-disk-barrier", false)
    else
      @aug.rm("#{@context}/disk/no-disk-barrier")
    end
  end

  def no_disk_drain
    @aug.exists("#{@context}/disk/no-disk-drain") ? :true : :false
  end

  def no_disk_drain=(value)
    if value == :true
      @aug.insert("#{@context}/disk", "no-disk-drain", false)
    else
      @aug.rm("#{@context}/disk/no-disk-drain")
    end
  end

  def no_md_flushes
    @aug.exists("#{@context}/disk/no-md-flushes") ? :true : :false
  end

  def no_md_flushes=(value)
    if value == :true
      @aug.insert("#{@context}/disk", "no-md-flushes", false)
    else
      @aug.rm("#{@context}/disk/no-md-flushes")
    end
  end

  def max_bio_bvecs
    @aug.get("#{@context}/disk/max-bio-bvecs")
  end

  def max_bio_bvecs=(value)
    if value.nil?
      @aug.rm("#{@context}/disk/max-bio-bvecs")
    else
      @aug.set("#{@context}/disk/max-bio-bvecs", value.to_s)
    end
  end
end
