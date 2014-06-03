# encoding: UTF-8
load '/home/papri/git_work/dqscripts/algocorpus/mongoentities.rb'

#@corpus = []
@mongoties = ["Sequence alignment", "Commentz-Walter algorithm", "Rabin–Karp algorithm", "Hamming distance", "Inversion (discrete mathematics)", "Jaccard index", "Jaro–Winkler distance", "Stable marriage problem", "Blum Blum Shub", "Linear congruential generator", "Mersenne twister", "Linear search", "Binary search algorithm", "Jump search", "Interpolation search", "Longest increasing subsequence problem", "FM-index", "Generalised suffix tree", "Judy array", "Ctree", "K-ary tree", "Andâ€“or tree", "(a,b)-tree", "Link/cut tree", "SPQR-tree", "Disjoint-set data structure", "Enfilade (Xanadu)", "Fenwick tree", "Van Emde Boas tree", "Segment tree", "Interval tree", "Range tree", "Bin (computational geometry)", "Kd-tree", "Min/max kd-tree", "Adaptive k-d tree", "Quadtree", "Octree", "Linear octree", "UB-tree", "R-tree", "R+ tree", "R* tree", "Hilbert R-tree", "X-tree", "Metric tree", "Cover tree", "M-tree", "VP-tree", "Bounding interval hierarchy", "BSP tree", "Rapidly exploring random tree", "Abstract syntax tree", "Parse tree", "Decision tree", "Alternating decision tree", "Minmax", "Expectiminimax tree", "Algorithms for calculating variance", "Approximate counting algorithm", "Bayesian statistics", "Nested sampling algorithm", "UPGMA", "DBSCAN", "Linde–Buzo–Gray algorithm", "OPTICS algorithm", "RANSAC", "AdaBoost", "LPBoost", "Perceptron", "Reinforcement Learning", "SARSA", "Temporal difference learning", "Support Vector Machines", "Structured SVM"]
@mongoties.each do |m|
	@resources = []
	Google::Search::Image.new(:query=>m).each do |w|
		@resources << w.uri
		if @resources.length > 9
			break	
		end
		puts m
		puts @resources
		@corpus[m] = @resources
	end
end
