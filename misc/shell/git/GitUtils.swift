import "git/GitModifier.applescript"
import "file/ScriptLoader.scpt"
import "git/GitParser.applescript"
import "git/GitAsserter.applescript"
class GitUtils{
	class var gitPath :String = "/usr/local/git/bin/" //to execute git commands we need to call the git commands from this path
	/*
	 * Manual pull
	 * CAUTION: its best practice to always commit any uncommited files before you attempt to pull. 
	 * CAUTION: remember to wrap this method in a try error clause, so that you can handle merge conflicts
	 * NOTE: the goal of this method is to arrive at the same state as the remote branch
	 * TODO: add support for different local and remote branch name
	 */
	class func manualPull(locaPath:String, _ remotePath:String, _ branch:String){
		//log ("GitUtil's manual_pull()")
		GitModifiers.fetch(locaPath, remotePath, branch) //--git fetch origin master, retrive the latest repo info
		let isRemoteBranchAhead:Bool to GitAsserters.isRemoteBranchAhead(localPath, branch) //--use the git log oneline thing here	--git log --oneline master..origin/master (to view the commit ids of the commits that the remote repo is ahead of local repo )
		//--log tab & "is_remote_branch_ahead: " & is_remote_branch_ahead
		if isRemoteBranchAhead { //--asserts if a merge isneeded
			//log tab & "remote branch is ahead, so there is something to merge"
			GitModifiers.merge(localPath, branch, "origin/" + branch) //--git merge master origin/master (merges the changes from remote that you just fetched)
		}else{
			//log tab & "nothing to merge, local branch is up-to-date"
		}
	}
	/*
	 * Manually clone a git to a local folder
	 * NOTE:  same as clone but differs in that it clones into an existing folder
	 * TODO: this method is wrong see git workflows on gitsyncs github.com
	 */
	class func manualClone(locaPath:String, _ remotePath:String){
		//--"git init" <--Installs the invisible .git folder
		//--TODO: do reasearch with different posix paths ~/testing/ vs Users/Joe/testing vs macintosh hd/ user / etc, and how to convert between them
		//--"git remote add origin https://github.com/user/testing.git" <-- attach a remote repo
		//--"git fetch origin master" <--Download the latest .git data
		//--"git checkout master" <-- Switches to the master branch (if you are already there then skip this)
		//--"git fetch origin master" <-- Do this Again to download the latest .git data  , since your ahead sort of
	}
}