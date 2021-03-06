// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: packages.proto

package com.chaoslabgames.packet;

/**
 * Protobuf type {@code com.chaoslabgames.packet.PointPkg}
 */
public final class PointPkg extends
    com.google.protobuf.GeneratedMessage implements
    // @@protoc_insertion_point(message_implements:com.chaoslabgames.packet.PointPkg)
    PointPkgOrBuilder {
  // Use PointPkg.newBuilder() to construct.
  private PointPkg(com.google.protobuf.GeneratedMessage.Builder<?> builder) {
    super(builder);
    this.unknownFields = builder.getUnknownFields();
  }
  private PointPkg(boolean noInit) { this.unknownFields = com.google.protobuf.UnknownFieldSet.getDefaultInstance(); }

  private static final PointPkg defaultInstance;
  public static PointPkg getDefaultInstance() {
    return defaultInstance;
  }

  public PointPkg getDefaultInstanceForType() {
    return defaultInstance;
  }

  private final com.google.protobuf.UnknownFieldSet unknownFields;
  @java.lang.Override
  public final com.google.protobuf.UnknownFieldSet
      getUnknownFields() {
    return this.unknownFields;
  }
  private PointPkg(
      com.google.protobuf.CodedInputStream input,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws com.google.protobuf.InvalidProtocolBufferException {
    initFields();
    int mutable_bitField0_ = 0;
    com.google.protobuf.UnknownFieldSet.Builder unknownFields =
        com.google.protobuf.UnknownFieldSet.newBuilder();
    try {
      boolean done = false;
      while (!done) {
        int tag = input.readTag();
        switch (tag) {
          case 0:
            done = true;
            break;
          default: {
            if (!parseUnknownField(input, unknownFields,
                                   extensionRegistry, tag)) {
              done = true;
            }
            break;
          }
          case 13: {
            bitField0_ |= 0x00000001;
            x_ = input.readFloat();
            break;
          }
          case 21: {
            bitField0_ |= 0x00000002;
            y_ = input.readFloat();
            break;
          }
        }
      }
    } catch (com.google.protobuf.InvalidProtocolBufferException e) {
      throw e.setUnfinishedMessage(this);
    } catch (java.io.IOException e) {
      throw new com.google.protobuf.InvalidProtocolBufferException(
          e.getMessage()).setUnfinishedMessage(this);
    } finally {
      this.unknownFields = unknownFields.build();
      makeExtensionsImmutable();
    }
  }
  public static final com.google.protobuf.Descriptors.Descriptor
      getDescriptor() {
    return com.chaoslabgames.packet.Packet.internal_static_com_chaoslabgames_packet_PointPkg_descriptor;
  }

  protected com.google.protobuf.GeneratedMessage.FieldAccessorTable
      internalGetFieldAccessorTable() {
    return com.chaoslabgames.packet.Packet.internal_static_com_chaoslabgames_packet_PointPkg_fieldAccessorTable
        .ensureFieldAccessorsInitialized(
            com.chaoslabgames.packet.PointPkg.class, com.chaoslabgames.packet.PointPkg.Builder.class);
  }

  public static com.google.protobuf.Parser<PointPkg> PARSER =
      new com.google.protobuf.AbstractParser<PointPkg>() {
    public PointPkg parsePartialFrom(
        com.google.protobuf.CodedInputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws com.google.protobuf.InvalidProtocolBufferException {
      return new PointPkg(input, extensionRegistry);
    }
  };

  @java.lang.Override
  public com.google.protobuf.Parser<PointPkg> getParserForType() {
    return PARSER;
  }

  private int bitField0_;
  public static final int X_FIELD_NUMBER = 1;
  private float x_;
  /**
   * <code>required float x = 1;</code>
   */
  public boolean hasX() {
    return ((bitField0_ & 0x00000001) == 0x00000001);
  }
  /**
   * <code>required float x = 1;</code>
   */
  public float getX() {
    return x_;
  }

  public static final int Y_FIELD_NUMBER = 2;
  private float y_;
  /**
   * <code>required float y = 2;</code>
   */
  public boolean hasY() {
    return ((bitField0_ & 0x00000002) == 0x00000002);
  }
  /**
   * <code>required float y = 2;</code>
   */
  public float getY() {
    return y_;
  }

  private void initFields() {
    x_ = 0F;
    y_ = 0F;
  }
  private byte memoizedIsInitialized = -1;
  public final boolean isInitialized() {
    byte isInitialized = memoizedIsInitialized;
    if (isInitialized == 1) return true;
    if (isInitialized == 0) return false;

    if (!hasX()) {
      memoizedIsInitialized = 0;
      return false;
    }
    if (!hasY()) {
      memoizedIsInitialized = 0;
      return false;
    }
    memoizedIsInitialized = 1;
    return true;
  }

  public void writeTo(com.google.protobuf.CodedOutputStream output)
                      throws java.io.IOException {
    getSerializedSize();
    if (((bitField0_ & 0x00000001) == 0x00000001)) {
      output.writeFloat(1, x_);
    }
    if (((bitField0_ & 0x00000002) == 0x00000002)) {
      output.writeFloat(2, y_);
    }
    getUnknownFields().writeTo(output);
  }

  private int memoizedSerializedSize = -1;
  public int getSerializedSize() {
    int size = memoizedSerializedSize;
    if (size != -1) return size;

    size = 0;
    if (((bitField0_ & 0x00000001) == 0x00000001)) {
      size += com.google.protobuf.CodedOutputStream
        .computeFloatSize(1, x_);
    }
    if (((bitField0_ & 0x00000002) == 0x00000002)) {
      size += com.google.protobuf.CodedOutputStream
        .computeFloatSize(2, y_);
    }
    size += getUnknownFields().getSerializedSize();
    memoizedSerializedSize = size;
    return size;
  }

  private static final long serialVersionUID = 0L;
  @java.lang.Override
  protected java.lang.Object writeReplace()
      throws java.io.ObjectStreamException {
    return super.writeReplace();
  }

  public static com.chaoslabgames.packet.PointPkg parseFrom(
      com.google.protobuf.ByteString data)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data);
  }
  public static com.chaoslabgames.packet.PointPkg parseFrom(
      com.google.protobuf.ByteString data,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data, extensionRegistry);
  }
  public static com.chaoslabgames.packet.PointPkg parseFrom(byte[] data)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data);
  }
  public static com.chaoslabgames.packet.PointPkg parseFrom(
      byte[] data,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws com.google.protobuf.InvalidProtocolBufferException {
    return PARSER.parseFrom(data, extensionRegistry);
  }
  public static com.chaoslabgames.packet.PointPkg parseFrom(java.io.InputStream input)
      throws java.io.IOException {
    return PARSER.parseFrom(input);
  }
  public static com.chaoslabgames.packet.PointPkg parseFrom(
      java.io.InputStream input,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws java.io.IOException {
    return PARSER.parseFrom(input, extensionRegistry);
  }
  public static com.chaoslabgames.packet.PointPkg parseDelimitedFrom(java.io.InputStream input)
      throws java.io.IOException {
    return PARSER.parseDelimitedFrom(input);
  }
  public static com.chaoslabgames.packet.PointPkg parseDelimitedFrom(
      java.io.InputStream input,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws java.io.IOException {
    return PARSER.parseDelimitedFrom(input, extensionRegistry);
  }
  public static com.chaoslabgames.packet.PointPkg parseFrom(
      com.google.protobuf.CodedInputStream input)
      throws java.io.IOException {
    return PARSER.parseFrom(input);
  }
  public static com.chaoslabgames.packet.PointPkg parseFrom(
      com.google.protobuf.CodedInputStream input,
      com.google.protobuf.ExtensionRegistryLite extensionRegistry)
      throws java.io.IOException {
    return PARSER.parseFrom(input, extensionRegistry);
  }

  public static Builder newBuilder() { return Builder.create(); }
  public Builder newBuilderForType() { return newBuilder(); }
  public static Builder newBuilder(com.chaoslabgames.packet.PointPkg prototype) {
    return newBuilder().mergeFrom(prototype);
  }
  public Builder toBuilder() { return newBuilder(this); }

  @java.lang.Override
  protected Builder newBuilderForType(
      com.google.protobuf.GeneratedMessage.BuilderParent parent) {
    Builder builder = new Builder(parent);
    return builder;
  }
  /**
   * Protobuf type {@code com.chaoslabgames.packet.PointPkg}
   */
  public static final class Builder extends
      com.google.protobuf.GeneratedMessage.Builder<Builder> implements
      // @@protoc_insertion_point(builder_implements:com.chaoslabgames.packet.PointPkg)
      com.chaoslabgames.packet.PointPkgOrBuilder {
    public static final com.google.protobuf.Descriptors.Descriptor
        getDescriptor() {
      return com.chaoslabgames.packet.Packet.internal_static_com_chaoslabgames_packet_PointPkg_descriptor;
    }

    protected com.google.protobuf.GeneratedMessage.FieldAccessorTable
        internalGetFieldAccessorTable() {
      return com.chaoslabgames.packet.Packet.internal_static_com_chaoslabgames_packet_PointPkg_fieldAccessorTable
          .ensureFieldAccessorsInitialized(
              com.chaoslabgames.packet.PointPkg.class, com.chaoslabgames.packet.PointPkg.Builder.class);
    }

    // Construct using com.chaoslabgames.packet.PointPkg.newBuilder()
    private Builder() {
      maybeForceBuilderInitialization();
    }

    private Builder(
        com.google.protobuf.GeneratedMessage.BuilderParent parent) {
      super(parent);
      maybeForceBuilderInitialization();
    }
    private void maybeForceBuilderInitialization() {
      if (com.google.protobuf.GeneratedMessage.alwaysUseFieldBuilders) {
      }
    }
    private static Builder create() {
      return new Builder();
    }

    public Builder clear() {
      super.clear();
      x_ = 0F;
      bitField0_ = (bitField0_ & ~0x00000001);
      y_ = 0F;
      bitField0_ = (bitField0_ & ~0x00000002);
      return this;
    }

    public Builder clone() {
      return create().mergeFrom(buildPartial());
    }

    public com.google.protobuf.Descriptors.Descriptor
        getDescriptorForType() {
      return com.chaoslabgames.packet.Packet.internal_static_com_chaoslabgames_packet_PointPkg_descriptor;
    }

    public com.chaoslabgames.packet.PointPkg getDefaultInstanceForType() {
      return com.chaoslabgames.packet.PointPkg.getDefaultInstance();
    }

    public com.chaoslabgames.packet.PointPkg build() {
      com.chaoslabgames.packet.PointPkg result = buildPartial();
      if (!result.isInitialized()) {
        throw newUninitializedMessageException(result);
      }
      return result;
    }

    public com.chaoslabgames.packet.PointPkg buildPartial() {
      com.chaoslabgames.packet.PointPkg result = new com.chaoslabgames.packet.PointPkg(this);
      int from_bitField0_ = bitField0_;
      int to_bitField0_ = 0;
      if (((from_bitField0_ & 0x00000001) == 0x00000001)) {
        to_bitField0_ |= 0x00000001;
      }
      result.x_ = x_;
      if (((from_bitField0_ & 0x00000002) == 0x00000002)) {
        to_bitField0_ |= 0x00000002;
      }
      result.y_ = y_;
      result.bitField0_ = to_bitField0_;
      onBuilt();
      return result;
    }

    public Builder mergeFrom(com.google.protobuf.Message other) {
      if (other instanceof com.chaoslabgames.packet.PointPkg) {
        return mergeFrom((com.chaoslabgames.packet.PointPkg)other);
      } else {
        super.mergeFrom(other);
        return this;
      }
    }

    public Builder mergeFrom(com.chaoslabgames.packet.PointPkg other) {
      if (other == com.chaoslabgames.packet.PointPkg.getDefaultInstance()) return this;
      if (other.hasX()) {
        setX(other.getX());
      }
      if (other.hasY()) {
        setY(other.getY());
      }
      this.mergeUnknownFields(other.getUnknownFields());
      return this;
    }

    public final boolean isInitialized() {
      if (!hasX()) {
        
        return false;
      }
      if (!hasY()) {
        
        return false;
      }
      return true;
    }

    public Builder mergeFrom(
        com.google.protobuf.CodedInputStream input,
        com.google.protobuf.ExtensionRegistryLite extensionRegistry)
        throws java.io.IOException {
      com.chaoslabgames.packet.PointPkg parsedMessage = null;
      try {
        parsedMessage = PARSER.parsePartialFrom(input, extensionRegistry);
      } catch (com.google.protobuf.InvalidProtocolBufferException e) {
        parsedMessage = (com.chaoslabgames.packet.PointPkg) e.getUnfinishedMessage();
        throw e;
      } finally {
        if (parsedMessage != null) {
          mergeFrom(parsedMessage);
        }
      }
      return this;
    }
    private int bitField0_;

    private float x_ ;
    /**
     * <code>required float x = 1;</code>
     */
    public boolean hasX() {
      return ((bitField0_ & 0x00000001) == 0x00000001);
    }
    /**
     * <code>required float x = 1;</code>
     */
    public float getX() {
      return x_;
    }
    /**
     * <code>required float x = 1;</code>
     */
    public Builder setX(float value) {
      bitField0_ |= 0x00000001;
      x_ = value;
      onChanged();
      return this;
    }
    /**
     * <code>required float x = 1;</code>
     */
    public Builder clearX() {
      bitField0_ = (bitField0_ & ~0x00000001);
      x_ = 0F;
      onChanged();
      return this;
    }

    private float y_ ;
    /**
     * <code>required float y = 2;</code>
     */
    public boolean hasY() {
      return ((bitField0_ & 0x00000002) == 0x00000002);
    }
    /**
     * <code>required float y = 2;</code>
     */
    public float getY() {
      return y_;
    }
    /**
     * <code>required float y = 2;</code>
     */
    public Builder setY(float value) {
      bitField0_ |= 0x00000002;
      y_ = value;
      onChanged();
      return this;
    }
    /**
     * <code>required float y = 2;</code>
     */
    public Builder clearY() {
      bitField0_ = (bitField0_ & ~0x00000002);
      y_ = 0F;
      onChanged();
      return this;
    }

    // @@protoc_insertion_point(builder_scope:com.chaoslabgames.packet.PointPkg)
  }

  static {
    defaultInstance = new PointPkg(true);
    defaultInstance.initFields();
  }

  // @@protoc_insertion_point(class_scope:com.chaoslabgames.packet.PointPkg)
}

