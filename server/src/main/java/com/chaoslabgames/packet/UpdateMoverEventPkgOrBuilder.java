// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: packages.proto

package com.chaoslabgames.packet;

public interface UpdateMoverEventPkgOrBuilder extends
    // @@protoc_insertion_point(interface_extends:com.chaoslabgames.packet.UpdateMoverEventPkg)
    com.google.protobuf.MessageOrBuilder {

  /**
   * <code>required int64 id = 1;</code>
   */
  boolean hasId();
  /**
   * <code>required int64 id = 1;</code>
   */
  long getId();

  /**
   * <code>required int64 tickId = 2;</code>
   */
  boolean hasTickId();
  /**
   * <code>required int64 tickId = 2;</code>
   */
  long getTickId();

  /**
   * <code>required .com.chaoslabgames.packet.MoverDataPkg moverData = 3;</code>
   */
  boolean hasMoverData();
  /**
   * <code>required .com.chaoslabgames.packet.MoverDataPkg moverData = 3;</code>
   */
  com.chaoslabgames.packet.MoverDataPkg getMoverData();
  /**
   * <code>required .com.chaoslabgames.packet.MoverDataPkg moverData = 3;</code>
   */
  com.chaoslabgames.packet.MoverDataPkgOrBuilder getMoverDataOrBuilder();
}
