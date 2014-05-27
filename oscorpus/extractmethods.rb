load '/home/papri/git_work/dqscripts/oscorpus/osboot.rb'
load '/home/papri/git_work/dqscripts/oscorpus/corpus.rb'
load '/home/papri/git_work/dqscripts/oscorpus/lecturecorpus.rb'

def video(key)
	yt = []
	@lecturecorpus['Basic Concepts'][key].each do |x|
		if x[1].include?("youtube")
			yt << x[1].split('http://www.youtube.com/watch?v=')[1]
		end
	end
	return yt 
end

def lectures(key)
	ln = []
	formatregex = /.pdf|.doc|.ppt|.ps|.pps/
	@lecturecorpus['Basic Concepts'][key].each do |x|
		if x[1] =~ formatregex
			ln << x
		end
	end
	return ln
end

@oscorpus = {"Basic Concepts" => {}}

@lecturecorpus['Basic Concepts'].each do |t|
	c = video(t[0])
	@oscorpus["Basic Concepts"][t[0]] = {}
	@oscorpus["Basic Concepts"][t[0]]['video_yt'] = c
	c = lectures(t[0])
	@oscorpus["Basic Concepts"][t[0]]['lectures'] = c
end
