# -*- encoding : utf-8 -*-
class String
  KEYBOARDS = {
      en: 'qwertyuiop[]asdfghjkl;\'zxcvbnm,./',
      ru: 'йцукенгшщзхъфывапролджэячсмитьбю/'
  }

  # switch between keyboards
  def tr_lang(from=nil, to=nil)
    return '' if self.blank?

    unless from || to
      if KEYBOARDS[:en].index(self[0])
        from, to = :en, :ru
      elsif KEYBOARDS[:ru].index(self[0])
        from, to = :ru, :en
      else
        from, to = :en, :ru
      end
    end

    self.tr(KEYBOARDS[from], KEYBOARDS[to])
  end

end

unless ''.respond_to?(:each)
  String.class_eval do
    def each &block
      self.lines &block
    end
  end
end
