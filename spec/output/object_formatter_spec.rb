require File.expand_path('../../spec_helper', __FILE__)
require "xcodeproj/output/object_formatter"
require "xcodeproj/output/pbx_file_formatter"

describe "Object output" do

  def output_of_object_with_uuid (uuid)
    @project ||= Xcodeproj::Project.new(fixture_path("Sample Project/Cocoa Application.xcodeproj"))
    formatter = Xcodeproj::PBXFileFormatter.new
    build_configuration = @project.objects_by_uuid[uuid]
    build_configuration.output_to_formatter(formatter)
    formatter.formatted_file
  end

  it "outputs PBXAggregateTarget objects" do
    output_of_object_with_uuid('E550D6AA16371AF600A003E9').should ==
    <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E550D6AA16371AF600A003E9 /* Aggregate */ = {
      isa = PBXAggregateTarget;
      buildConfigurationList = E550D6AB16371AF600A003E9 /* Build configuration list for PBXAggregateTarget "Aggregate" */;
      buildPhases = (
        E550D8F8163733DE00A003E9 /* CopyFiles */,
        E550D8F9163733DF00A003E9 /* ShellScript */,
      );
      dependencies = (
        E550D6AF16371AFC00A003E9 /* PBXTargetDependency */,
      );
      name = Aggregate;
      productName = Aggregate;
    };
    EXPECTED_OUTPUT
  end

  it "outputs PBXBuildFile objects" do
    output_of_object_with_uuid('E525239B16245A900012E2BA').should ==
    <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E525239B16245A900012E2BA /* InfoPlist.strings in Resources */ = {isa = PBXBuildFile; fileRef = E525239916245A900012E2BA /* InfoPlist.strings */; };
    EXPECTED_OUTPUT
  end

  it "outputs PBXBuildRule objects" do
    output_of_object_with_uuid('E525244116245B280012E2BA').should ==
    <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E525244116245B280012E2BA /* PBXBuildRule */ = {
      isa = PBXBuildRule;
      compilerSpec = com.apple.compilers.proxy.script;
      fileType = pattern.proxy;
      isEditable = 1;
      outputFiles = (
      );
    };
    EXPECTED_OUTPUT
  end

  it "outputs PBXContainerItemProxy objects" do
    output_of_object_with_uuid('E52523B716245A910012E2BA').should ==
    <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E52523B716245A910012E2BA /* PBXContainerItemProxy */ = {
      isa = PBXContainerItemProxy;
      containerPortal = E525238316245A900012E2BA /* Project object */;
      proxyType = 1;
      remoteGlobalIDString = E525238B16245A900012E2BA;
      remoteInfo = "Cocoa Application";
    };
    EXPECTED_OUTPUT
  end

  it "outputs PBXCopyFilesBuildPhase objects" do
    output_of_object_with_uuid('E525243E16245B1A0012E2BA').should ==
    <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E525243E16245B1A0012E2BA /* CopyFiles */ = {
      isa = PBXCopyFilesBuildPhase;
      buildActionMask = 2147483647;
      dstPath = "";
      dstSubfolderSpec = 7;
      files = (
      );
      runOnlyForDeploymentPostprocessing = 0;
    };
    EXPECTED_OUTPUT
  end

  it "outputs PBXFileReference objects" do
    output_of_object_with_uuid('E525239816245A900012E2BA').should ==
    <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E525239816245A900012E2BA /* Cocoa Application-Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = "Cocoa Application-Info.plist"; sourceTree = "<group>"; };
    EXPECTED_OUTPUT
  end

  it "outputs PBXFrameworksBuildPhase objects" do
    output_of_object_with_uuid('E52523C316245A910012E2BA').should ==
    <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E52523C316245A910012E2BA /* Frameworks */ = {
      isa = PBXFrameworksBuildPhase;
      buildActionMask = 2147483647;
      files = (
        E52523CB16245A910012E2BA /* CoreServices.framework in Frameworks */,
        E52523CD16245A910012E2BA /* CoreFoundation.framework in Frameworks */,
        E52523CF16245A910012E2BA /* CoreData.framework in Frameworks */,
        E52523D116245A910012E2BA /* Foundation.framework in Frameworks */,
      );
      runOnlyForDeploymentPostprocessing = 0;
    };
    EXPECTED_OUTPUT
  end

  it "outputs PBXGroup objects" do
    output_of_object_with_uuid('E525238D16245A900012E2BA').should ==
    <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E525238D16245A900012E2BA /* Products */ = {
      isa = PBXGroup;
      children = (
        E525238C16245A900012E2BA /* Cocoa Application.app */,
        E52523B316245A910012E2BA /* Cocoa ApplicationTests.octest */,
        E52523C616245A910012E2BA /* Cocoa ApplicationImporter.mdimporter */,
        E52523F416245AB20012E2BA /* iOS application.app */,
        E525241F16245AB20012E2BA /* iOS applicationTests.octest */,
        E550D6B916371B1A00A003E9 /* UnitTestingBundle.octest */,
        E550D6CB16371B2800A003E9 /* InAppPurchaseContent */,
        E550D6D616371B3300A003E9 /* PlugIn.bundle */,
        E550D6EE16371B3B00A003E9 /* KernelExtension.kext */,
        E550D70216371B4400A003E9 /* ImageUnitPlugIn.plugin */,
        E550D72816371B4E00A003E9 /* IOKitDriver.kext */,
        E550D73C16371B5A00A003E9 /* MacRubyPrefPanel.prefPane */,
        E550D75E16371B6300A003E9 /* PreferencePanel.prefPane */,
        E550D77916371B6A00A003E9 /* QuickLook.qlgenerator */,
        E550D79516371B7100A003E9 /* ScreenSaver.saver */,
        E550D7AA16371B7A00A003E9 /* SpotLightImporter.mdimporter */,
        E550D7C616371B8F00A003E9 /* AutomatorAction.action */,
        E550D7DE16371B9800A003E9 /* AddressBookPlugIn.bundle */,
        E550D7F216371BA500A003E9 /* InstallerPlugIn.bundle */,
        E550D81016371BAF00A003E9 /* QuartzComposerPlugIn.plugin */,
        E550D82816371BC400A003E9 /* CocoaFramework.framework */,
        E550D83B16371BCA00A003E9 /* Library.dylib */,
        E550D84A16371BD000A003E9 /* Bundle.bundle */,
        E550D85A16371BD600A003E9 /* org.cocoapods.XPCServic.xpc */,
        E550D86C16371BE100A003E9 /* libC/C++ Library.dylib */,
        E550D87416371BEE00A003E9 /* STL C++ Library.dylib */,
        E550D88516371C0600A003E9 /* CocoaAppleScriptApp.app */,
        E550D8A516371C0F00A003E9 /* CommandLineTool */,
        E550D8B616371C1700A003E9 /* MacRubyApplication.app */,
        E550D8D816371C1800A003E9 /* MacRubyApplicationImporter.mdimporter */,
      );
      name = Products;
      sourceTree = "<group>";
    };
    EXPECTED_OUTPUT
  end

  it "outputs PBXGroup objects without name" do
    output_of_object_with_uuid('E525239616245A900012E2BA').should ==
        <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E525239616245A900012E2BA /* Cocoa Application */ = {
      isa = PBXGroup;
      children = (
        E5FBB2D216357C70009E96B0 /* Cocoa Application.entitlements */,
        E525239716245A900012E2BA /* Supporting Files */,
        E52523A216245A900012E2BA /* CPDocument.h */,
        E52523A316245A900012E2BA /* CPDocument.m */,
        E52523A516245A900012E2BA /* CPDocument.xib */,
        E52523A816245A910012E2BA /* MainMenu.xib */,
      );
      path = "Cocoa Application";
      sourceTree = "<group>";
    };
    EXPECTED_OUTPUT
  end

  it "outputs PBXHeadersBuildPhase objects" do
    output_of_object_with_uuid('E525244016245B230012E2BA').should ==
    <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E525244016245B230012E2BA /* Headers */ = {
      isa = PBXHeadersBuildPhase;
      buildActionMask = 2147483647;
      files = (
      );
      runOnlyForDeploymentPostprocessing = 0;
    };
    EXPECTED_OUTPUT
  end

  it "outputs PBXLegacyTarget objects" do
    output_of_object_with_uuid('E550D8BA16371C1700A003E9').should ==
    <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E550D8BA16371C1700A003E9 /* Deployment */ = {
      isa = PBXLegacyTarget;
      buildArgumentsString = "--compile --embed";
      buildConfigurationList = E550D8F516371C1800A003E9 /* Build configuration list for PBXLegacyTarget "Deployment" */;
      buildPhases = (
      );
      buildToolPath = /usr/local/bin/macruby_deploy;
      dependencies = (
        E550D8BC16371C1700A003E9 /* PBXTargetDependency */,
      );
      name = Deployment;
      passBuildSettingsInEnvironment = 1;
      productName = Deployment;
    };
    EXPECTED_OUTPUT
  end

  it "outputs PBXNativeTarget objects" do
    output_of_object_with_uuid('E525238B16245A900012E2BA').should ==
    <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E525238B16245A900012E2BA /* Cocoa Application */ = {
      isa = PBXNativeTarget;
      buildConfigurationList = E52523E616245A910012E2BA /* Build configuration list for PBXNativeTarget "Cocoa Application" */;
      buildPhases = (
        E525238816245A900012E2BA /* Sources */,
        E525238916245A900012E2BA /* Frameworks */,
        E525238A16245A900012E2BA /* Resources */,
        E5DCFBD916285415002C6803 /* Headers */,
        E5DCFBDB16285429002C6803 /* Custom name copy */,
        E5DCFBDC16285431002C6803 /* Custom name */,
      );
      buildRules = (
        E552E0F916263968003ED1FE /* PBXBuildRule */,
        E552E0F716263967003ED1FE /* PBXBuildRule */,
      );
      dependencies = (
        E52523C816245A910012E2BA /* PBXTargetDependency */,
      );
      name = "Cocoa Application";
      productName = "Cocoa Application";
      productReference = E525238C16245A900012E2BA /* Cocoa Application.app */;
      productType = "com.apple.product-type.application";
    };
    EXPECTED_OUTPUT
  end

  it "outputs PBXProject objects" do
    output_of_object_with_uuid('E525238316245A900012E2BA').should ==
    <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E525238316245A900012E2BA /* Project object */ = {
      isa = PBXProject;
      attributes = {
        CLASSPREFIX = CP;
        LastUpgradeCheck = 0450;
        ORGANIZATIONNAME = CocoaPods;
      };
      buildConfigurationList = E525238616245A900012E2BA /* Build configuration list for PBXProject "?????" */;
      compatibilityVersion = "Xcode 3.1";
      developmentRegion = English;
      hasScannedForEncodings = 0;
      knownRegions = (
        en,
        Base,
      );
      mainGroup = E525238116245A900012E2BA;
      productRefGroup = E525238D16245A900012E2BA /* Products */;
      projectDirPath = "";
      projectReferences = (
        {
          ProductGroup = E5FBB3461635ED35009E96B0 /* Products */;
          ProjectRef = E5FBB3451635ED35009E96B0 /* ReferencedProject.xcodeproj */;
        },
      );
      projectRoot = "";
      targets = (
        E525238B16245A900012E2BA /* Cocoa Application */,
        E52523B216245A910012E2BA /* Cocoa ApplicationTests */,
        E52523C516245A910012E2BA /* Cocoa ApplicationImporter */,
        E52523F316245AB20012E2BA /* iOS application */,
        E525241E16245AB20012E2BA /* iOS applicationTests */,
        E550D6AA16371AF600A003E9 /* Aggregate */,
        E550D6B016371B0600A003E9 /* External */,
        E550D6B816371B1A00A003E9 /* UnitTestingBundle */,
        E550D6CA16371B2800A003E9 /* InAppPurchaseContent */,
        E550D6D516371B3300A003E9 /* PlugIn */,
        E550D6ED16371B3B00A003E9 /* KernelExtension */,
        E550D70116371B4400A003E9 /* ImageUnitPlugIn */,
        E550D72716371B4E00A003E9 /* IOKitDriver */,
        E550D73B16371B5A00A003E9 /* MacRubyPrefPanel */,
        E550D75D16371B6300A003E9 /* PreferencePanel */,
        E550D77816371B6A00A003E9 /* QuickLook */,
        E550D79416371B7100A003E9 /* ScreenSaver */,
        E550D7A916371B7A00A003E9 /* SpotLightImporter */,
        E550D7C516371B8F00A003E9 /* AutomatorAction */,
        E550D7DD16371B9800A003E9 /* AddressBookPlugIn */,
        E550D7F116371BA500A003E9 /* InstallerPlugIn */,
        E550D80F16371BAF00A003E9 /* QuartzComposerPlugIn */,
        E550D82716371BC400A003E9 /* CocoaFramework */,
        E550D83A16371BCA00A003E9 /* Library */,
        E550D84916371BD000A003E9 /* Bundle */,
        E550D85916371BD600A003E9 /* XPCServic */,
        E550D86B16371BE100A003E9 /* C/C++ Library */,
        E550D87316371BEE00A003E9 /* STL C++ Library */,
        E550D88416371C0600A003E9 /* CocoaAppleScriptApp */,
        E550D8A416371C0F00A003E9 /* CommandLineTool */,
        E550D8B516371C1700A003E9 /* MacRubyApplication */,
        E550D8BA16371C1700A003E9 /* Deployment */,
        E550D8D716371C1800A003E9 /* MacRubyApplicationImporter */,
      );
    };
    EXPECTED_OUTPUT
  end

  it "outputs PBXReferenceProxy objects" do
    output_of_object_with_uuid('E5FBB34C1635ED36009E96B0').should ==
    <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E5FBB34C1635ED36009E96B0 /* ReferencedProject.app */ = {
      isa = PBXReferenceProxy;
      fileType = wrapper.application;
      path = ReferencedProject.app;
      remoteRef = E5FBB34B1635ED36009E96B0 /* PBXContainerItemProxy */;
      sourceTree = BUILT_PRODUCTS_DIR;
    };
    EXPECTED_OUTPUT
  end

  it "outputs PBXResourcesBuildPhase objects" do
    output_of_object_with_uuid('E52523F216245AB20012E2BA').should ==
    <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E52523F216245AB20012E2BA /* Resources */ = {
      isa = PBXResourcesBuildPhase;
      buildActionMask = 2147483647;
      files = (
        E525240116245AB20012E2BA /* InfoPlist.strings in Resources */,
        E525240916245AB20012E2BA /* Default.png in Resources */,
        E525240B16245AB20012E2BA /* Default@2x.png in Resources */,
        E525240D16245AB20012E2BA /* Default-568h@2x.png in Resources */,
        E525241016245AB20012E2BA /* MainStoryboard.storyboard in Resources */,
      );
      runOnlyForDeploymentPostprocessing = 0;
    };
    EXPECTED_OUTPUT
  end

  it "outputs PBXShellScriptBuildPhase objects" do
    output_of_object_with_uuid('E550D80E16371BAF00A003E9').should ==
    <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E550D80E16371BAF00A003E9 /* ShellScript */ = {
      isa = PBXShellScriptBuildPhase;
      buildActionMask = 2147483647;
      files = (
      );
      inputPaths = (
      );
      outputPaths = (
      );
      runOnlyForDeploymentPostprocessing = 0;
      shellPath = /bin/sh;
      shellScript = "# This shell script simply copies the built plug-in to \\\"~/Library/Graphics/Quartz Composer Plug-Ins\\\" and overrides any previous version at that location\\n\\nmkdir -p \\\"$USER_LIBRARY_DIR/Graphics/Quartz Composer Plug-Ins\\\"\\nrm -rf \\\"$USER_LIBRARY_DIR/Graphics/Quartz Composer Plug-Ins/QuartzComposerPlugIn.plugin\\\"\\ncp -rf \\\"$BUILT_PRODUCTS_DIR/QuartzComposerPlugIn.plugin\\\" \\\"$USER_LIBRARY_DIR/Graphics/Quartz Composer Plug-Ins/\\\"\\n";
    };
    EXPECTED_OUTPUT
  end

  it "outputs PBXSourcesBuildPhase objects" do
    output_of_object_with_uuid('E52523F016245AB20012E2BA').should ==
    <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E52523F016245AB20012E2BA /* Sources */ = {
      isa = PBXSourcesBuildPhase;
      buildActionMask = 2147483647;
      files = (
        E525240316245AB20012E2BA /* main.m in Sources */,
        E525240716245AB20012E2BA /* CPAppDelegate.m in Sources */,
        E525241316245AB20012E2BA /* iOS_application.xcdatamodeld in Sources */,
        E525241616245AB20012E2BA /* CPMasterViewController.m in Sources */,
        E525241916245AB20012E2BA /* CPDetailViewController.m in Sources */,
      );
      runOnlyForDeploymentPostprocessing = 0;
    };
    EXPECTED_OUTPUT
  end

  it "outputs PBXTargetDependency objects" do
    output_of_object_with_uuid('5138059C16499F4C001D82AD').should ==
    <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    5138059C16499F4C001D82AD /* PBXTargetDependency */ = {
      isa = PBXTargetDependency;
      name = ReferencedProject;
      targetProxy = 5138059B16499F4C001D82AD /* PBXContainerItemProxy */;
    };
    EXPECTED_OUTPUT
  end

  it "outputs PBXVariantGroup objects" do
    output_of_object_with_uuid('E525240E16245AB20012E2BA').should ==
    <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E525240E16245AB20012E2BA /* MainStoryboard.storyboard */ = {
      isa = PBXVariantGroup;
      children = (
        E525240F16245AB20012E2BA /* en */,
      );
      name = MainStoryboard.storyboard;
      sourceTree = "<group>";
    };
    EXPECTED_OUTPUT
  end

  it "outputs XCBuildConfiguration objects" do
    output_of_object_with_uuid('E52523E316245A910012E2BA').should ==
    <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E52523E316245A910012E2BA /* Build configuration list for PBXNativeTarget "Cocoa ApplicationImporter" */ = {
      isa = XCConfigurationList;
      buildConfigurations = (
        E52523E416245A910012E2BA /* Debug */,
        E52523E516245A910012E2BA /* Release */,
      );
      defaultConfigurationIsVisible = 0;
      defaultConfigurationName = Release;
    };
    EXPECTED_OUTPUT
  end

  it "outputs XCConfigurationList objects" do
    output_of_object_with_uuid('E525238616245A900012E2BA').should ==
        <<-EXPECTED_OUTPUT.chomp("\n").gsub(/^    /,"").gsub(/(?<=  )?  /,"\t")
    E525238616245A900012E2BA /* Build configuration list for PBXProject "?????" */ = {
      isa = XCConfigurationList;
      buildConfigurations = (
        E52523E116245A910012E2BA /* Debug */,
        E52523E216245A910012E2BA /* Release */,
      );
      defaultConfigurationIsVisible = 0;
      defaultConfigurationName = Release;
    };
    EXPECTED_OUTPUT
  end

end