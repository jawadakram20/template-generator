class AddTagsValuesIntoTextService
  
  def initialize(plaintext)
    @plaintext = plaintext
    @error_message = nil
  end
  
  def get_document
      @plaintext = @plaintext.split("[")
      @text=[]
      @plaintext.each do | plaintext |
        rem_text=plaintext.partition(']').last
        if plaintext[0..6] == 'CLAUSE-'
          clause_id = plaintext.split("-").last.split("]").first.to_i
          if Clause.where(id: clause_id).present?
            @text << Clause.find(clause_id).text
          else
            @error_message ="Clause id not found"
          end
          @text << rem_text
        elsif plaintext[0..7] == 'SECTION-'
          section_id = plaintext.split("-").last.split("]").first.to_i
          if Section.where(id: section_id).present?
            Section.find(section_id).clauses.each do |clause|
              @text<< "#{clause.text};"
            end 
          else
            @error_message ="Section id not found"
          end
          @text << rem_text
        else
          @text << plaintext
        end
      end
      @plaintext=@text.join(' ')
      @plaintext
  end

  def get_error_message
    @error_message
  end

end