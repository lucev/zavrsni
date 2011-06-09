module NewsHelper

  def translate status
    if status == 'public'
      return 'javno'
    elsif status == 'suggested'
      return 'predloženo'
    elsif status == 'internal'
      return 'interno'
    elsif status == 'hidden'
      return 'skriveno'
    else
      return status
    end
  end

end

