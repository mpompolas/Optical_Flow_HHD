function TriConn = faces_connectivity(FV,VERBOSE);
%FACES_CONNECTIVITY - Generate the connections of faces to a vertex
% function TriConn = faces_connectivity(FV,VERBOSE);
% FV is the standard matlab structure for faces and vertices,
%  where FV.faces is m x 3, and FV.vertices is n x 3.
%
% TriConn returned is vector of cells, one-to-one with each row of FV.vertices.
% TriConn{i} returns a row vector of the face numbers (rows in FV.faces) that
%  are connected to the ith vertex row in FV.vertices.
%
% Thus if we want the faces numbers for a given set of vertices, TriConn{i} will tell
%  us which faces to use in for instance a patch command.
%
% See also VERTICES_CONNECTIVITY

%<autobegin> ---------------------- 27-Jun-2005 10:44:17 -----------------------
% ------ Automatically Generated Comments Block Using AUTO_COMMENTS_PRE7 -------
%
% CATEGORY: Visualization
%
% At Check-in: $Author: mosher $  $Revision: 20 $  $Date: 2006-02-10 18:03:10 -0800 (Fri, 10 Feb 2006) $
%
% This software is part of BrainStorm Toolbox Version 27-June-2005  
% 
% Principal Investigators and Developers:
% ** Richard M. Leahy, PhD, Signal & Image Processing Institute,
%    University of Southern California, Los Angeles, CA
% ** John C. Mosher, PhD, Biophysics Group,
%    Los Alamos National Laboratory, Los Alamos, NM
% ** Sylvain Baillet, PhD, Cognitive Neuroscience & Brain Imaging Laboratory,
%    CNRS, Hopital de la Salpetriere, Paris, France
% 
% See BrainStorm website at http://neuroimage.usc.edu for further information.
% 
% Copyright (c) 2005 BrainStorm by the University of Southern California
% This software distributed  under the terms of the GNU General Public License
% as published by the Free Software Foundation. Further details on the GPL
% license can be found at http://www.gnu.org/copyleft/gpl.html .
% 
% FOR RESEARCH PURPOSES ONLY. THE SOFTWARE IS PROVIDED "AS IS," AND THE
% UNIVERSITY OF SOUTHERN CALIFORNIA AND ITS COLLABORATORS DO NOT MAKE ANY
% WARRANTY, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
% MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, NOR DO THEY ASSUME ANY
% LIABILITY OR RESPONSIBILITY FOR THE USE OF THIS SOFTWARE.
%<autoend> ------------------------ 27-Jun-2005 10:44:17 -----------------------

% ----------------------------- Script History ---------------------------------
% Author: John C. Mosher, Ph.D.
% 19-Nov-99 Based on May 1998 scripts.
% JCM 19-May-2004 Comments cleaning
% ----------------------------- Script History ---------------------------------

if(~exist('VERBOSE','var')),
   VERBOSE = 1; % default non-silent running of waitbars
end

nv = size(FV.vertices,1);
[nf,ns] = size(FV.faces); % number of faces, number of sides per face

TriConn = cell(nv,1); % one empty cell per vertex

if(VERBOSE),
   % disp(sprintf('Processing %.0f faces',nf))
   hwait = waitbar(0,sprintf('Processing the Triangle Connectivity for %.0f faces',nf));
   drawnow %flush the display
end

for iv = 1:nf, % use each face's information
   if(VERBOSE)
      if(~rem(iv,max(1,round(nf/10)))), % ten updates
         % fprintf(' %.0f',iv);
         waitbar(iv/nf,hwait);
         drawnow %flush the display         
      end
   end
   for i = 1:ns, %each vertex of the face
      TriConn{FV.faces(iv,i)}(end+1) = iv;
   end
end
close(hwait);

return
