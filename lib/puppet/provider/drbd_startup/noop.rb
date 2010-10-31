Puppet::Type.type(:drbd_startup).provide(:noop) do
  desc "Noop provider"

  confine :false => File.exists? "/usr/share/augeas/lenses/drbd.aug"

  def create
  end

  def destroy
  end

  def exists?
    resource[:ensure] == :present ? true : false
  end

  def wfc_timeout
    resource[:wfc_timeout]
  end

  def wfc_timeout=(value)
  end

  def degr_wfc_timeout
    resource[:degr_wfc_timeout]
  end

  def degr_wfc_timeout=(value)
  end

  def outdated_wfc_timeout
    resource[:outdated_wfc_timeout]
  end

  def outdated_wfc_timeout=(value)
  end

  def wait_after_sb
    resource[:wait_after_sb]
  end

  def wait_after_sb=(value)
  end

  def become_primary_on
    resource[:become_primary_on]
  end

  def become_primary_on=(value)
  end
end
