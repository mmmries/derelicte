module Derelicte
  class Inliner
    def inline(html_str, css_str)
      doc = ::Derelicte.doc_from_str(html_str)
      analyzer = ::Derelicte.css_analyzer_from_str(css_str)
      job = InlinerJob.new(doc, analyzer)
      job.apply_rules_to_doc
      ::Derelicte.doc_to_str(job.doc)
    end
  end
end
