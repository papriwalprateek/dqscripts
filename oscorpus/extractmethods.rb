# This file contains extraction methods which extract content from lecturecorpus and classifies it.

load '/home/papri/git_work/dqscripts/oscorpus/osboot.rb'
load '/home/papri/git_work/dqscripts/oscorpus/oscorpus.rb'
load '/home/papri/git_work/dqscripts/oscorpus/lecturecorpus.rb'
load '/home/papri/git_work/dqscripts/oscorpus/corpus.rb'
load '/home/papri/git_work/dqscripts/svm/svm_predict.rb'
load '/home/papri/git_work/dqscripts/oscorpus/articlecorpus.rb'

def video(key,cat)
	yt = []
	@lecturecorpus[cat][key].each do |x|
		if x[1].include?("youtube")
			yt << x[1].split('http://www.youtube.com/watch?v=')[1]
		end
	end
	return yt 
end

def lectures(key,cat)
	ln = []
	formatregex = /.pdf|.doc|.ppt|.ps|.pps/
	@lecturecorpus[cat][key].each do |x|
		if x[1] =~ formatregex
			ln << x
		end
	end
	return ln
end

def lecturestuff(cat)
	@oscorpus[cat].each do |t|
		c = video(t[0],cat)
		puts c
		puts t[0]
		@oscorpus[cat][t[0]]['video_yt'] = c
		c = lectures(t[0],cat)
		@oscorpus[cat][t[0]]['lectures'] = c
	end
end

def webarticles(cat)
	formatregex = /.pdf|.ppt|.ps|.pps|youtube/
	@lecturecorpus[cat].each do |k,v|
		puts k
		v.each do |t|
			if t[1] =~ formatregex
			else
				pred = svm_predict(t[1])
				if pred == 1.0 or t[1].include?('freevideolectures')
				puts t[1]
				@corpus[cat][k] << t
				end
			end

		end
	end
end


def techtarget(cat)
end
