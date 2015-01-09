require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/wordcount')

get('/') do
  erb(:form)
end

get('/wordcount') do
  phrase = params.fetch('phrase')
  word = params.fetch('word')

  if phrase == "" || word == ""
    @message = "<span class='error'>Invalid input. Please fill in both input fields.</span>"
  elsif word.include?(" ")
    @message = "<span class='error'>Invalid input. Please search for a single word only.</span>"
  else
    counter = phrase.wordcount(word)
    if counter == 0
      @message = "I could not locate the word &ldquo;<span class='word'>".concat(word).concat("</span>&rdquo; in your text.")
    elsif counter == 1
      @message = "I found the word &ldquo;<span class='word'>".concat(word).concat("</span>&rdquo; ").concat(counter.to_s).concat(" time in your text.")
    else
      @message = "I found the word &ldquo;<span class='word'>".concat(word).concat("</span>&rdquo; ").concat(counter.to_s).concat(" times in your text.")
    end
  end 

  erb(:wordcount)
end
