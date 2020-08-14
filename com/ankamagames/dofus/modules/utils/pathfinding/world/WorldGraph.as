package com.ankamagames.dofus.modules.utils.pathfinding.world
{
    import flash.utils.Dictionary;
    import flash.utils.ByteArray;
    import __AS3__.vec.Vector;
    import __AS3__.vec.*;

    public class WorldGraph 
    {

        private var _vertices:Dictionary = new Dictionary();
        private var _edges:Dictionary = new Dictionary();
        private var _outgoingEdges:Dictionary = new Dictionary();
        private var _vertexUid:Number = 0;

        public function WorldGraph(data:ByteArray)
        {
            var from:Vertex;
            var dest:Vertex;
            var edge:Edge;
            var transitionCount:int;
            var j:int;
            super();
            var edgeCount:int = data.readInt();
            var i:int;
            while (i < edgeCount)
            {
                from = this.addVertex(data.readDouble(), data.readInt());
                dest = this.addVertex(data.readDouble(), data.readInt());
                edge = this.addEdge(from, dest);
                transitionCount = data.readInt();
                j = 0;
                while (j < transitionCount)
                {
                    edge.addTransition(data.readByte(), data.readByte(), data.readInt(), data.readUTFBytes(data.readInt()), data.readDouble(), data.readInt(), data.readDouble());
                    j++;
                };
                i++;
            };
        }

        public function getEdges():Dictionary
        {
            return (this._edges);
        }

        public function addVertex(mapId:Number, zone:int):Vertex
        {
            if (this._vertices[mapId] == null)
            {
                this._vertices[mapId] = new Dictionary();
            };
            var vertex:Vertex = this._vertices[mapId][zone];
            if (vertex == null)
            {
                vertex = new Vertex(mapId, zone, this._vertexUid++);
                this._vertices[mapId][zone] = vertex;
            };
            return (vertex);
        }

        public function getVertex(mapId:Number, mapRpZone:int):Vertex
        {
            if (this._vertices[mapId] == null)
            {
                return (null);
            };
            return (this._vertices[mapId][mapRpZone]);
        }

        public function getOutgoingEdgesFromVertex(from:Vertex):Vector.<Edge>
        {
            return (this._outgoingEdges[from.UID]);
        }

        public function getEdge(from:Vertex, dest:Vertex):Edge
        {
            if (this._edges[from.UID] == null)
            {
                return (null);
            };
            return (this._edges[from.UID][dest.UID]);
        }

        public function addEdge(from:Vertex, dest:Vertex):Edge
        {
            var edge:Edge = this.getEdge(from, dest);
            if (edge != null)
            {
                return (edge);
            };
            if (((!(this.doesVertexExist(from))) || (!(this.doesVertexExist(dest)))))
            {
                return (null);
            };
            edge = new Edge(from, dest);
            if (this._edges[from.UID] == null)
            {
                this._edges[from.UID] = new Dictionary();
            };
            this._edges[from.UID][dest.UID] = edge;
            var outgoing:Vector.<Edge> = this._outgoingEdges[from.UID];
            if (outgoing == null)
            {
                outgoing = new Vector.<Edge>();
                this._outgoingEdges[from.UID] = outgoing;
            };
            outgoing.push(edge);
            return (edge);
        }

        public function doesVertexExist(v:Vertex):Boolean
        {
            return (!(this._vertices[v.mapId][v.zoneId] == null));
        }


    }
} com.ankamagames.dofus.modules.utils.pathfinding.world

