Puppet::Type.type(:drbd_disk).provide(:noop) do
  desc "Dummy provider"

  confine :false => File.exists? "/usr/share/augeas/lenses/drbd.aug"

  def create
  end

  def destroy
  end

  def exists?
    resource[:ensure] == :present ? true : false
  end

  def on_io_error
    resource[:on_io_error]
  end

  def on_io_error=(value)
  end

  def size
    resource[:size]
  end

  def size=(value)
  end

  def fencing
    resource[:fencing]
  end

  def fencing=(value)
  end

  def use_bmbv
    resource[:use_bmbv]
  end

  def use_bmbv=(value)
  end

  def no_disk_flushes
    resource[:no_disk_flushes]
  end

  def no_disk_flushes=(value)
  end

  def no_disk_barrier
    resource[:no_disk_barrier]
  end

  def no_disk_barrier=(value)
  end

  def no_disk_drain
    resource[:no_disk_drain]
  end

  def no_disk_drain=(value)
  end

  def no_md_flushes
    resource[:no_md_flushes]
  end

  def no_md_flushes=(value)
  end

  def max_bio_bvecs
    resource[:max_bio_bvecs]
  end

  def max_bio_bvecs=(value)
  end
end
