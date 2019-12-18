class MySubnavGenerator < Jekyll::Generator
  safe true

  def generate(site)
    paintingsCollection = ""
    site.collections.each do |collection|
      label = collection[0]
      contents = collection[1]
      if label == 'paintingspoems'
        paintingsCollection = contents
      end
    end

    paintingsCollection.each do |post|
      poemLink = (post.data['poem-page'] || 'poem')
      paintingLink = (post.data['painting-page'] || 'painting')

      dir = post.url

      isPretty = (Jekyll.configuration({})['permalink'] == 'pretty')
      post.data['painting-path'] = File.join(dir, paintingLink) + (isPretty ? '' : post.output_ext)
      post.data['poem-path'] = File.join(dir, poemLink) + (isPretty ? '' : post.output_ext)
      post.data['post-id'] = post.url

      site.pages << PoemPage.new(site, site.source, dir, poemLink, paintingLink, post)
      site.pages << PaintingPage.new(site, site.source, dir, paintingLink, poemLink, post)
    end
  end
end

class PoemPage < Jekyll::Page
  def initialize(site, base, dir, name, other, post)
    @site = site
    @base = base
    @dir  = dir
    @name = name + post.output_ext

    self.process(@name)

    self.data = post.data.clone()
    self.content = post.content.clone()

    self.data['layout'] = 'poem'
    self.data['painting-path'] = post.data['painting-path']
    self.data['poem-path'] = post.data['poem-path']
    self.data['is-poem'] = true
    self.data['is-painting'] = false
  end
end

class PaintingPage < Jekyll::Page
  def initialize(site, base, dir, name, other, post)
    @site = site
    @base = base
    @dir  = dir
    @name = name + post.output_ext

    self.process(@name)

    self.data = post.data.clone()
    self.content = post.content.clone()

    self.data['layout'] = 'painting'
    self.data['painting-path'] = post.data['painting-path']
    self.data['poem-path'] = post.data['poem-path']
    self.data['is-poem'] = false
    self.data['is-painting'] = true
  end
end