function tests = jointBuilderTest
%JOINTBUILDERTEST Test implementation of the joint builder.
%
% About this main function:
% The main function collects all of the local test functions
% into a test array. Since it is the main function, the function name
% corresponds to the name of your .m file and follows the naming convention
% of starting or ending in the word 'test', which is case-insensitive.
%
% To run tests from the command prompt, use the runtests command with your
% MATLAB test file as input. For example:
%
%   results = runtests('exampleTest.m')
%
% Alternatively, you can run tests using the run function.
%
%   results = run(exampleTest)
%
% To analyze the test results, examine the output structure from runtests
% or run. For each test, the result contains the name of the test function,
% whether it passed, failed, or didn't complete, and the time it took to
% run the test.
tests = functiontests(localfunctions);
end

% Setup and teardown code, also referred to as test fixture functions,
% set up the pretest state of the system and return it to the original
% state after running the test. There are two types of these functions:
% FILE FIXTURE functions that run once per test file, and FRESH FIXTURE
% functions that run before and after each local test function. These
% functions are not required to generate tests. In general, it is
% preferable to use fresh fixtures over file fixtures to increase unit test
% encapsulation.
%
% A function test case object, testCase, must be the only input to file
% fixture and fresh fixture functions. The Unit Test Framework
% automatically generates this object.
%
% The TestCase object is a means to pass information between setup
% functions, test functions, and teardown functions. Its TestData property
% is, by default, a struct, which allows easy addition of fields and data.
% Typical uses for this test data include paths and graphics handles.


% ----------------- FILE FIXTURE -----------------------
function setupOnce(testCase)  % do not change function name
% set a new path, for example

% cleanup console
close all;
clc;

% instantiate a joint builder
testCase.('TestData').JB = jointBuilder;
testCase.('TestData').JB.overwrite = 1; % Overwrite existing model files.

testCase.('TestData').allParams = {'WMBig10k_ds';
    'WMBig10k';
    'WMBig2300_ds'};


end

function teardownOnce(testCase)  % do not change function name
% change back to original path, for example

testCase.('TestData').JB.purge; % remove all files created during the tests

end

% % ----------------- FRESH FIXTURE -----------------------
% function setup(testCase)  % do not change function name
% % open a figure, for example
% end
% % 
% function teardown(testCase)  % do not change function name
% % close figure, for example
% end
% % -----------------------------------------------

% Individual test functions are included as local functions in the same
% MATLAB file as the main (test-generating) function. These test function
% names must begin or end with the case-insensitive word, 'test'. Each of
%the local test functions must accept a single input, which is a function
% test case object, testCase. The Unit Test Framework automatically
% generates this object.
%
% A test function is also called a "Qualification". There exist different
% conceptual types of qualifications.
function testNoFrictionModels(testCase)
% Test specific code

% shorthands
jb = testCase.('TestData').JB;
allParams = testCase.('TestData').allParams;
nPar = numel(allParams);

% tests
    for iPar = 1:nPar
        jb.buildJoint(allParams{iPar},'continuous_full_no_friction');
        jb.buildJoint(allParams{iPar},'continuous_output_fixed_no_friction');
        jb.buildJoint(allParams{iPar},'continuous_rigid_gearbox_no_friction');
        jb.buildJoint(allParams{iPar},'continuous_output_fixed_rigid_gearbox_no_friction');
        jb.buildJoint(allParams{iPar},'continuous_rigid_no_friction');
    end

    verifyTrue(testCase,true) % If we arrive here, everything is fine.
    
end

function testCoulombModels(testCase)
% Test to build models with coulomb friction.

% shorthands
jb = testCase.('TestData').JB;
allParams = testCase.('TestData').allParams;
nPar = numel(allParams);

% tests
    for iPar = 1:nPar
        jb.buildJoint(allParams{iPar}, 'continuous_full', 'coulomb');
        jb.buildJoint(allParams{iPar}, 'continuous_output_fixed', 'coulomb');
        jb.buildJoint(allParams{iPar}, 'continuous_rigid_gearbox', 'coulomb');
        jb.buildJoint(allParams{iPar}, 'continuous_output_fixed_rigid_gearbox', 'coulomb');

        % Coulomb friction - asymmetric
        jb.buildJoint(allParams{iPar}, 'continuous_full', 'coulomb_asym');
        jb.buildJoint(allParams{iPar}, 'continuous_output_fixed', 'coulomb_asym');
        jb.buildJoint(allParams{iPar}, 'continuous_rigid_gearbox', 'coulomb_asym');
        jb.buildJoint(allParams{iPar}, 'continuous_output_fixed_rigid_gearbox', 'coulomb_asym');
    end
    verifyTrue(testCase,true) % If we arrive here, everything is fine.
end


function testPositionDependentModels(testCase)
% Test to build models with position dependent disturbances.

% shorthands
jb = testCase.('TestData').JB;
allParams = testCase.('TestData').allParams;
nPar = numel(allParams);

% tests
    for iPar = 1:nPar
        
        jb.buildJoint(allParams{iPar}, 'continuous_full', 'viscous_pos_dep');
        jb.buildJoint(allParams{iPar}, 'continuous_output_fixed', 'viscous_pos_dep');
        jb.buildJoint(allParams{iPar}, 'continuous_rigid_gearbox', 'viscous_pos_dep');
        jb.buildJoint(allParams{iPar}, 'continuous_output_fixed_rigid_gearbox', 'viscous_pos_dep');
        
    end
    verifyTrue(testCase,true) % If we arrive here, everything is fine.
end


function testPositionDependentModels(testCase)
% Test to build models with position dependent disturbances.

% shorthands
jb = testCase.('TestData').JB;
allParams = testCase.('TestData').allParams;
nPar = numel(allParams);

% tests
    for iPar = 1:nPar
        
        jb.buildJoint(allParams{iPar}, 'continuous_full', 'viscous_pos_dep');
        jb.buildJoint(allParams{iPar}, 'continuous_output_fixed', 'viscous_pos_dep');
        jb.buildJoint(allParams{iPar}, 'continuous_rigid_gearbox', 'viscous_pos_dep');
        jb.buildJoint(allParams{iPar}, 'continuous_output_fixed_rigid_gearbox', 'viscous_pos_dep');
        
    end
    verifyTrue(testCase,true) % If we arrive here, everything is fine.
end

function testMultipleNonlinearTerms(testCase)
% Test to build models with combinations of nonlinear terms

% shorthands
jb = testCase.('TestData').JB;
allParams = testCase.('TestData').allParams;
nPar = numel(allParams);

% tests
    for iPar = 1:nPar
    
        jb.buildJoint(allParams{iPar}, 'continuous_full', {'coulomb', 'viscous_asym'});
        jb.buildJoint(allParams{iPar}, 'continuous_output_fixed', {'coulomb_asym', 'viscous_asym'});
        jb.buildJoint(allParams{iPar}, 'continuous_rigid_gearbox', {'coulomb', 'viscous_asym'});
        jb.buildJoint(allParams{iPar}, 'continuous_output_fixed_rigid_gearbox', {'coulomb_asym', 'viscous_asym'});
        
    end
    verifyTrue(testCase,true) % If we arrive here, everything is fine.
end

    
    