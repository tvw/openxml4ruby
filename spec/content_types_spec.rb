require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
include OpenXML4Ruby

describe "ContentType::Default" do
  before(:all) do
    @ct = ContentType::Default.new("image", "png")
    @noko = noko{|xml| @ct.to_xml(xml)}
  end

  it "should have 'image' as content_type" do
    @ct.content_type.should == "image"
  end

  it "should have 'png' as extension" do
    @ct.extension.should == "png"
  end

  it "should have one tag" do
    @noko.children.length.should == 1
  end

  it "should have no children" do
    @noko.children.first.children.length.should == 0
  end

  it "should have a 'Default' tag" do
    @noko.children.first.name.should == "Default"
  end

  it "should have all attributes" do
    @noko.children.first.should have_attributes("ContentType" => "image", "Extension" => "png")
  end
end

describe "ContentType::Override" do
  before(:all) do
    @ct = ContentType::Override.new("doc", "some_part")
    @noko = noko{|xml| @ct.to_xml(xml)}
  end

  it "should have 'doc' as content_type" do
    @ct.content_type.should == "doc"
  end

  it "should have 'some_part' as part_name" do
    @ct.part_name.should == "some_part"
  end

  it "should have one tag" do
    @noko.children.length.should == 1
  end

  it "should have no children" do
    @noko.children.first.children.length.should == 0
  end

  it "should have a 'Override' tag" do
    @noko.children.first.name.should == "Override"
  end

  it "should have all attributes" do
    @noko.children.first.should have_attributes("ContentType" => "doc", "PartName" => "some_part")
  end
end
