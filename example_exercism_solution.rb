# Exercism.io offers a platform for Ruby kata submission and community feedback. This is just one of the katas I have submitted

module BookKeeping

  VERSION = 4

end

class Complement

  class << self

    INCOMPLETE_OR_ERROR_RESULT = ''
    attr_accessor :dna_nucleotide

    def of_dna(dna_nucleotide)
      @dna_nucleotide = dna_nucleotide

      complementize
    end

    def complementize
      result = ''
      dna_nucleotide.each_char { |c| result << rna_complement(c) }
      error_check(result)
    end

  private

    def error_check(result)
      if result.include? Rna::PROBLEM_FLAG
        INCOMPLETE_OR_ERROR_RESULT
      else
        result
      end
    end
    
    def rna_complement(char)
      Rna.complement(char)
    end

  end

end

class Rna

  PROBLEM_FLAG = '!'

  def self.complement(dna_char)
    case dna_char
    when 'G'
      'C'
    when 'C'
      'G'
    when 'T'
      'A'
    when 'A'
      'U'
    else
      PROBLEM_FLAG
    end
  end

end
